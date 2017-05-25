#!/bin/sh

alias dm="docker-machine"
alias dc="docker-compose"
alias di="docker images"
alias dps="docker ps"
alias dcps="docker-compose ps"
alias docker_clean_ps='docker rm $(docker ps --filter=status=exited --filter=status=created -q)'

drmi() {
  images=$(docker images -q -f dangling=true)
  if [[ -z "$images" ]]; then
     echo "No images to delete."
  else
    docker rmi -f $(printf " %s" "${images[@]}")
  fi
}
