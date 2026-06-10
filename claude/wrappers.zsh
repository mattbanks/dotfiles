#!/bin/sh
# Claude Code per-profile auth wrappers.
#
# macOS stores Claude Code's OAuth login in the GUI-only Keychain, so a bare
# `claude` over SSH reports "not logged in". These wrappers inject the
# credential from a local 0600 file instead, which outranks the Keychain in
# Claude Code's auth precedence and works headless/over SSH.
#
# Tokens live outside any repo (never committed):
#   ~/.config/claude-tokens/personal.token  -> CLAUDE_CODE_OAUTH_TOKEN (Pro)
# Generate with: CLAUDE_CONFIG_DIR=~/.claude command claude setup-token
#
# If the token file is missing we fall back to the Keychain (local GUI works,
# SSH fails) so nothing regresses on machines without the file.

# Personal (Claude Pro subscription)
claude() {
    local tok="$HOME/.config/claude-tokens/personal.token"
    if [ -r "$tok" ]; then
        CLAUDE_CONFIG_DIR="$HOME/.claude" \
        CLAUDE_CODE_OAUTH_TOKEN="$(cat "$tok")" \
        command claude "$@"
    else
        CLAUDE_CONFIG_DIR="$HOME/.claude" command claude "$@"
    fi
}
