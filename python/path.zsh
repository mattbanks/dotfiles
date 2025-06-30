#!/bin/sh
# Pyenv setup and config
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"

export PATH="$HOME/.local/share/uv/python:$PATH"
