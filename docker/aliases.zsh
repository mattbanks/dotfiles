#!/bin/sh
alias d='docker'
alias dc='docker-compose'
alias docker_clean_ps='docker rm $(docker ps --filter=status=exited --filter=status=created -q)'

docker_prune() {
	docker system prune --volumes -fa
}
