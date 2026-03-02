#!/bin/bash

set -f  # disable globbing

input=$(cat)

if [ -z "$input" ]; then
    printf "Claude"
    exit 0
fi

# ===== Account detection =====
# account_type: "oauth" = Claude.ai Pro/Max (has usage limits + OAuth token)
#               "api"   = Anthropic API console (token-based billing, no rate limit bars)
#
# Private accounts are defined in ~/.dotfiles-private/claude/statusline-accounts.sh
# That file sets: account, account_color, account_type, config_dir based on CLAUDE_CONFIG_DIR
# If the file doesn't exist or doesn't match, we fall through to the defaults below.

account=""
account_color=""
account_type=""
config_dir=""

private_accounts="${HOME}/.dotfiles-private/claude/statusline-accounts.sh"
if [ -f "$private_accounts" ]; then
    # shellcheck source=/dev/null
    source "$private_accounts"
fi

# Default: personal account (no CLAUDE_CONFIG_DIR or ~/.claude)
if [ -z "$account" ]; then
    if [ "$CLAUDE_CONFIG_DIR" = "~/.claude" ] || [ "$CLAUDE_CONFIG_DIR" = "$HOME/.claude" ] || [ -z "$CLAUDE_CONFIG_DIR" ]; then
        account="Personal"
        account_color='\033[38;2;0;153;255m'  # Blue
        account_type="oauth"
        config_dir="$HOME/.claude"
    else
        # Unknown config dir — treat as API account
        config_dir="${CLAUDE_CONFIG_DIR/#\~/$HOME}"
        account=$(basename "$config_dir" | sed 's/^\.claude-//')
        account_color='\033[38;2;255;176;85m'  # Orange
        account_type="api"
    fi
fi

# ===== ANSI colors =====
blue='\033[38;2;0;153;255m'
orange='\033[38;2;255;176;85m'
green='\033[38;2;0;160;0m'
cyan='\033[38;2;46;149;153m'
red='\033[38;2;255;85;85m'
yellow='\033[38;2;230;200;0m'
white='\033[38;2;220;220;220m'
dim='\033[2m'
reset='\033[0m'

# ===== Helper functions =====

# Format token counts (e.g., 50k / 200k)
format_tokens() {
    local num=$1
    if [ "$num" -ge 1000000 ]; then
        awk "BEGIN {printf \"%.1fm\", $num / 1000000}"
    elif [ "$num" -ge 1000 ]; then
        awk "BEGIN {printf \"%.0fk\", $num / 1000}"
    else
        printf "%d" "$num"
    fi
}

# Format number with commas (e.g., 134,938)
format_commas() {
    printf "%'d" "$1"
}

# Build a colored progress bar
# Usage: build_bar <pct> <width>
build_bar() {
    local pct=$1
    local width=$2
    [ "$pct" -lt 0 ] 2>/dev/null && pct=0
    [ "$pct" -gt 100 ] 2>/dev/null && pct=100

    local filled=$(( pct * width / 100 ))
    local empty=$(( width - filled ))

    local bar_color
    if [ "$pct" -ge 90 ]; then bar_color="$red"
    elif [ "$pct" -ge 70 ]; then bar_color="$yellow"
    elif [ "$pct" -ge 50 ]; then bar_color="$orange"
    else bar_color="$green"
    fi

    local filled_str="" empty_str=""
    for ((i=0; i<filled; i++)); do filled_str+="●"; done
    for ((i=0; i<empty; i++)); do empty_str+="○"; done

    printf "${bar_color}${filled_str}${dim}${empty_str}${reset}"
}

# Pad column to fixed width (ignoring ANSI codes)
# Usage: pad_column <text_with_ansi> <visible_length> <column_width>
pad_column() {
    local text="$1"
    local visible_len=$2
    local col_width=$3
    local padding=$(( col_width - visible_len ))
    if [ "$padding" -gt 0 ]; then
        printf "%s%*s" "$text" "$padding" ""
    else
        printf "%s" "$text"
    fi
}

# ===== Extract data from JSON =====
model_name=$(echo "$input" | jq -r '.model.display_name // "Claude"')
model_id=$(echo "$input" | jq -r '.model.id // .model.api_id // ""' | tr '[:upper:]' '[:lower:]')

# Context window
size=$(echo "$input" | jq -r '.context_window.context_window_size // 200000')
[ "$size" -eq 0 ] 2>/dev/null && size=200000

# Token usage (including cache tokens)
input_tokens=$(echo "$input" | jq -r '.context_window.current_usage.input_tokens // 0')
cache_create=$(echo "$input" | jq -r '.context_window.current_usage.cache_creation_input_tokens // 0')
cache_read=$(echo "$input" | jq -r '.context_window.current_usage.cache_read_input_tokens // 0')
output_tokens=$(echo "$input" | jq -r '.context_window.current_usage.output_tokens // 0')
current=$(( input_tokens + cache_create + cache_read ))

used_tokens=$(format_tokens $current)
total_tokens=$(format_tokens $size)

if [ "$size" -gt 0 ]; then
    pct_used=$(( current * 100 / size ))
else
    pct_used=0
fi
pct_remain=$(( 100 - pct_used ))

used_comma=$(format_commas $current)
remain_comma=$(format_commas $(( size - current )))

# Session cost — only meaningful for API accounts (Pro/Max is flat subscription)
# Pricing per million tokens: input / cache_write / cache_read / output
# Falls back to Sonnet rates if model is unrecognized
total_cost=""
if [ "$account_type" = "api" ]; then
    model_key="${model_id:-$(echo "$model_name" | tr '[:upper:]' '[:lower:]')}"
    if echo "$model_key" | grep -qi "opus"; then
        p_in=15; p_cw=18.75; p_cr=1.50; p_out=75
    elif echo "$model_key" | grep -qi "haiku"; then
        p_in=0.80; p_cw=1.00; p_cr=0.08; p_out=4
    else
        # Sonnet (default)
        p_in=3; p_cw=3.75; p_cr=0.30; p_out=15
    fi
    total_cost=$(echo "scale=4; \
        ($input_tokens * $p_in + \
         $cache_create * $p_cw + \
         $cache_read   * $p_cr + \
         $output_tokens * $p_out) / 1000000" | bc)
    # Format: show 4 decimal places if < $0.01, otherwise 2
    total_cost=$(echo "$total_cost" | awk '{
        if ($1 < 0.01) printf "%.4f", $1
        else printf "%.2f", $1
    }')
    [[ "$total_cost" == .* ]] && total_cost="0$total_cost"
fi

# Thinking status (account-aware)
thinking_on=false
settings_path="${config_dir}/settings.json"
if [ -f "$settings_path" ]; then
    thinking_val=$(jq -r '.alwaysThinkingEnabled // false' "$settings_path" 2>/dev/null)
    [ "$thinking_val" = "true" ] && thinking_on=true
fi

# ===== LINE 1: [Account] Model | tokens | % used | % remain | thinking | cost =====
sep=" ${dim}|${reset} "
line1=""
line1+="${account_color}[${account}]${reset}"
line1+=" ${blue}${model_name}${reset}"
line1+="${sep}"
line1+="${orange}${used_tokens} / ${total_tokens}${reset}"
line1+="${sep}"
line1+="${green}${pct_used}% used ${white}${used_comma}${reset}"
line1+="${sep}"
line1+="${cyan}${pct_remain}% remain ${white}${remain_comma}${reset}"
line1+="${sep}"
line1+="thinking: "
if $thinking_on; then
    line1+="${orange}on${reset}"
else
    line1+="${dim}off${reset}"
fi
if [ -n "$total_cost" ]; then
    line1+="${sep}"
    line1+="${green}\$${total_cost}${reset}"
fi

# ===== Account-aware OAuth token resolution =====
get_oauth_token() {
    local token=""

    # 1. Explicit env var override
    if [ -n "$CLAUDE_CODE_OAUTH_TOKEN" ]; then
        echo "$CLAUDE_CODE_OAUTH_TOKEN"
        return 0
    fi

    # 2. Account-specific credentials file (most reliable for multi-account)
    local creds_file="${config_dir}/.credentials.json"
    if [ -f "$creds_file" ]; then
        token=$(jq -r '.claudeAiOauth.accessToken // empty' "$creds_file" 2>/dev/null)
        if [ -n "$token" ] && [ "$token" != "null" ]; then
            echo "$token"
            return 0
        fi
    fi

    # 3. macOS Keychain — account-specific entry first, then fallback to default
    if command -v security >/dev/null 2>&1; then
        local blob
        # Derive the SHA256 keychain suffix Claude Code uses for non-default config dirs
        local config_hash
        config_hash=$(echo -n "$config_dir" | shasum -a 256 | cut -c1-8)
        blob=$(security find-generic-password -s "Claude Code-credentials-${config_hash}" -w 2>/dev/null)
        if [ -n "$blob" ]; then
            token=$(echo "$blob" | jq -r '.claudeAiOauth.accessToken // empty' 2>/dev/null)
            if [ -n "$token" ] && [ "$token" != "null" ]; then
                echo "$token"
                return 0
            fi
        fi
        # Fallback to default credentials entry
        blob=$(security find-generic-password -s "Claude Code-credentials" -w 2>/dev/null)
        if [ -n "$blob" ]; then
            token=$(echo "$blob" | jq -r '.claudeAiOauth.accessToken // empty' 2>/dev/null)
            if [ -n "$token" ] && [ "$token" != "null" ]; then
                echo "$token"
                return 0
            fi
        fi
    fi

    # 4. GNOME Keyring via secret-tool
    if command -v secret-tool >/dev/null 2>&1; then
        local blob
        blob=$(timeout 2 secret-tool lookup service "Claude Code-credentials" 2>/dev/null)
        if [ -n "$blob" ]; then
            token=$(echo "$blob" | jq -r '.claudeAiOauth.accessToken // empty' 2>/dev/null)
            if [ -n "$token" ] && [ "$token" != "null" ]; then
                echo "$token"
                return 0
            fi
        fi
    fi

    echo ""
}

# ===== LINE 2 & 3: Usage limits (oauth) or API indicator (api accounts) =====
account_lower=$(echo "$account" | tr '[:upper:]' '[:lower:]')
mkdir -p /tmp/claude

usage_data=""

if [ "$account_type" = "oauth" ]; then
    cache_file="/tmp/claude/statusline-usage-cache-${account_lower}.json"
    cache_max_age=60  # seconds between API calls

    needs_refresh=true
    if [ -f "$cache_file" ]; then
        cache_mtime=$(stat -f %m "$cache_file" 2>/dev/null || stat -c %Y "$cache_file" 2>/dev/null)
        now=$(date +%s)
        cache_age=$(( now - cache_mtime ))
        if [ "$cache_age" -lt "$cache_max_age" ]; then
            needs_refresh=false
            usage_data=$(cat "$cache_file" 2>/dev/null)
        fi
    fi

    if $needs_refresh; then
        token=$(get_oauth_token)
        if [ -n "$token" ] && [ "$token" != "null" ]; then
            response=$(curl -s --max-time 5 \
                -H "Accept: application/json" \
                -H "Content-Type: application/json" \
                -H "Authorization: Bearer $token" \
                -H "anthropic-beta: oauth-2025-04-20" \
                -H "User-Agent: claude-code/2.1.34" \
                "https://api.anthropic.com/api/oauth/usage" 2>/dev/null)
            if [ -n "$response" ] && echo "$response" | jq . >/dev/null 2>&1; then
                usage_data="$response"
                echo "$response" > "$cache_file"
            fi
        fi
        # Fall back to stale cache
        if [ -z "$usage_data" ] && [ -f "$cache_file" ]; then
            usage_data=$(cat "$cache_file" 2>/dev/null)
        fi
    fi
fi

# Cross-platform ISO to epoch conversion
iso_to_epoch() {
    local iso_str="$1"

    # Try GNU date first (Linux)
    local epoch
    epoch=$(date -d "${iso_str}" +%s 2>/dev/null)
    if [ -n "$epoch" ]; then
        echo "$epoch"
        return 0
    fi

    # BSD date (macOS) — strip fractional seconds and timezone
    local stripped="${iso_str%%.*}"
    stripped="${stripped%%Z}"
    stripped="${stripped%%+*}"
    stripped="${stripped%%-[0-9][0-9]:[0-9][0-9]}"

    if [[ "$iso_str" == *"Z"* ]] || [[ "$iso_str" == *"+00:00"* ]] || [[ "$iso_str" == *"-00:00"* ]]; then
        epoch=$(env TZ=UTC date -j -f "%Y-%m-%dT%H:%M:%S" "$stripped" +%s 2>/dev/null)
    else
        epoch=$(date -j -f "%Y-%m-%dT%H:%M:%S" "$stripped" +%s 2>/dev/null)
    fi

    [ -n "$epoch" ] && echo "$epoch" && return 0
    return 1
}

# Format ISO reset time to compact local time
# Usage: format_reset_time <iso_string> <style: time|datetime|date>
format_reset_time() {
    local iso_str="$1"
    local style="$2"
    [ -z "$iso_str" ] || [ "$iso_str" = "null" ] && return

    local epoch
    epoch=$(iso_to_epoch "$iso_str")
    [ -z "$epoch" ] && return

    case "$style" in
        time)
            date -j -r "$epoch" +"%l:%M%p" 2>/dev/null | sed 's/^ //' | tr '[:upper:]' '[:lower:]' || \
            date -d "@$epoch" +"%l:%M%P" 2>/dev/null | sed 's/^ //'
            ;;
        datetime)
            date -j -r "$epoch" +"%b %-d, %l:%M%p" 2>/dev/null | sed 's/  / /g; s/^ //' | tr '[:upper:]' '[:lower:]' || \
            date -d "@$epoch" +"%b %-d, %l:%M%P" 2>/dev/null | sed 's/  / /g; s/^ //'
            ;;
        *)
            date -j -r "$epoch" +"%b %-d" 2>/dev/null | tr '[:upper:]' '[:lower:]' || \
            date -d "@$epoch" +"%b %-d" 2>/dev/null
            ;;
    esac
}

line2=""
line3=""

if [ "$account_type" = "api" ]; then
    line2="${dim}API console · billed per token · no rate limits${reset}"
elif [ -n "$usage_data" ] && echo "$usage_data" | jq -e . >/dev/null 2>&1; then
    bar_width=10
    col1w=23
    col2w=22

    # ---- 5-hour (current) ----
    five_hour_pct=$(echo "$usage_data" | jq -r '.five_hour.utilization // 0' | awk '{printf "%.0f", $1}')
    five_hour_reset_iso=$(echo "$usage_data" | jq -r '.five_hour.resets_at // empty')
    five_hour_reset=$(format_reset_time "$five_hour_reset_iso" "time")
    five_hour_bar=$(build_bar "$five_hour_pct" "$bar_width")

    col1_bar_vis_len=$(( 9 + bar_width + 1 + ${#five_hour_pct} + 1 ))
    col1_bar="${white}current:${reset} ${five_hour_bar} ${cyan}${five_hour_pct}%${reset}"
    col1_bar=$(pad_column "$col1_bar" "$col1_bar_vis_len" "$col1w")

    col1_reset_plain="resets ${five_hour_reset}"
    col1_reset="${white}resets ${five_hour_reset}${reset}"
    col1_reset=$(pad_column "$col1_reset" "${#col1_reset_plain}" "$col1w")

    # ---- 7-day (weekly) ----
    seven_day_pct=$(echo "$usage_data" | jq -r '.seven_day.utilization // 0' | awk '{printf "%.0f", $1}')
    seven_day_reset_iso=$(echo "$usage_data" | jq -r '.seven_day.resets_at // empty')
    seven_day_reset=$(format_reset_time "$seven_day_reset_iso" "datetime")
    seven_day_bar=$(build_bar "$seven_day_pct" "$bar_width")

    col2_bar_vis_len=$(( 8 + bar_width + 1 + ${#seven_day_pct} + 1 ))
    col2_bar="${white}weekly:${reset} ${seven_day_bar} ${cyan}${seven_day_pct}%${reset}"
    col2_bar=$(pad_column "$col2_bar" "$col2_bar_vis_len" "$col2w")

    col2_reset_plain="resets ${seven_day_reset}"
    col2_reset="${white}resets ${seven_day_reset}${reset}"
    col2_reset=$(pad_column "$col2_reset" "${#col2_reset_plain}" "$col2w")

    # ---- Extra usage ----
    col3_bar=""
    col3_reset=""
    extra_enabled=$(echo "$usage_data" | jq -r '.extra_usage.is_enabled // false')
    if [ "$extra_enabled" = "true" ]; then
        extra_pct=$(echo "$usage_data" | jq -r '.extra_usage.utilization // 0' | awk '{printf "%.0f", $1}')
        extra_used=$(echo "$usage_data" | jq -r '.extra_usage.used_credits // 0' | awk '{printf "%.2f", $1/100}')
        extra_limit=$(echo "$usage_data" | jq -r '.extra_usage.monthly_limit // 0' | awk '{printf "%.2f", $1/100}')
        extra_bar=$(build_bar "$extra_pct" "$bar_width")
        extra_reset=$(date -v+1m -v1d +"%b %-d" | tr '[:upper:]' '[:lower:]')

        col3_bar="${white}extra:${reset} ${extra_bar} ${cyan}\$${extra_used}/\$${extra_limit}${reset}"
        col3_reset="${white}resets ${extra_reset}${reset}"
    fi

    # Assemble line 2: bars row
    line2="${col1_bar}${sep}${col2_bar}"
    [ -n "$col3_bar" ] && line2+="${sep}${col3_bar}"

    # Assemble line 3: resets row
    line3="${col1_reset}${sep}${col2_reset}"
    [ -n "$col3_reset" ] && line3+="${sep}${col3_reset}"
fi

# ===== Output =====
printf "%b" "$line1"
[ -n "$line2" ] && printf "\n%b" "$line2"
[ -n "$line3" ] && printf "\n%b" "$line3"

exit 0
