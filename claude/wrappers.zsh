#!/bin/sh
# Claude Code per-profile auth wrappers.
#
# Over SSH the login Keychain isn't unlocked, so a bare `claude` reports
# "not logged in". These wrappers inject a credential from a local 0600 file
# in that case, which outranks the Keychain in Claude Code's auth precedence.
#
# Tokens live outside any repo (never committed):
#   ~/.config/claude-tokens/personal.token  -> CLAUDE_CODE_OAUTH_TOKEN (Pro)
# Generate with: CLAUDE_CONFIG_DIR=~/.claude command claude setup-token
#
# The Keychain credential is preferred whenever it is readable, because the
# Pro OAuth login expires ~8h and Claude Code refreshes it in place. Injecting
# the static setup-token shadows that credential, so it stops being refreshed.
# Fall back to the token only when the Keychain can't be read (SSH, headless,
# locked keychain).
#
# Claude Code namespaces the item per config dir:
#   service = "Claude Code-credentials-" + sha256(CLAUDE_CONFIG_DIR)[0:8]
# Probe that exact name. An unsuffixed "Claude Code-credentials" item may also
# linger from older versions -- do NOT probe it, it is a tombstone and matching
# it would make this check pass even with no usable credential. If the naming
# scheme ever changes, the probe fails and we fall back to the token, which is
# merely the old behaviour, not a breakage.

# Personal (Claude Pro subscription)
claude() {
    local dir="$HOME/.claude"
    local tok="$HOME/.config/claude-tokens/personal.token"
    local svc="Claude Code-credentials-$(printf '%s' "$dir" | shasum -a 256 | cut -c1-8)"
    if security find-generic-password -s "$svc" -a "$USER" -w >/dev/null 2>&1; then
        CLAUDE_CONFIG_DIR="$dir" command claude "$@"
    elif [ -r "$tok" ]; then
        CLAUDE_CONFIG_DIR="$dir" \
        CLAUDE_CODE_OAUTH_TOKEN="$(cat "$tok")" \
        command claude "$@"
    else
        CLAUDE_CONFIG_DIR="$dir" command claude "$@"
    fi
}
