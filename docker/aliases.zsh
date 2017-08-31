#!/bin/sh
alias d='docker'
alias docker_clean_ps='docker rm $(docker ps --filter=status=exited --filter=status=created -q)'
