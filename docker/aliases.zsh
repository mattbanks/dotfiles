#!/bin/sh
export DOCKER_MACHINE_NAME=docker-host

alias dm="docker-machine"
alias dc="docker-compose"
alias dmr="docker-machine restart $DOCKER_MACHINE_NAME && reload-docker"
alias di="docker images"
alias dps="docker ps"
alias dcps="docker-compose ps"

drmi() {
  images=$(docker images -q -f dangling=true)
  if [[ -z "$images" ]]; then
     echo "No images to delete."
  else
    docker rmi -f $(printf " %s" "${images[@]}")
  fi
}

reload-docker() {
  eval "$(docker-machine env $DOCKER_MACHINE_NAME)"
}

# invoke this immeadiately
# reload-docker
