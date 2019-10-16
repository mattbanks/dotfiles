#!/bin/sh
docker_prune() {
	docker system prune --volumes -fa
}

docker_clean_ps() {
	docker rm $(docker ps --filter=status=exited --filter=status=created -q)
}
