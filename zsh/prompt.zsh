autoload colors && colors
# cheers, @ehrenmurdick
# http://github.com/ehrenmurdick/config/blob/master/zsh/prompt.zsh

if (( $+commands[git] ))
then
  git="$commands[git]"
else
  git="/usr/bin/git"
fi

git_branch() {
  echo $($git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

git_dirty() {
  st=$($git status 2>/dev/null | tail -n 1)
  if [[ $st == "" ]]
  then
    echo ""
  else
    if [[ "$st" =~ ^nothing ]]
    then
      echo "%{$fg[green]%}$(git_prompt_info)%{$reset_color%}"
    else
      echo "%{$fg_bold[red]%}$(git_prompt_info)%{$reset_color%}"
    fi
  fi
}

git_prompt_info () {
 ref=$($git symbolic-ref HEAD 2>/dev/null) || return
# echo "(%{\e[0;33m%}${ref#refs/heads/}%{\e[0m%})"
 echo "${ref#refs/heads/}"
}

git_repository_name() {
  if [ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1
  then
    top_path=$(git rev-parse --show-toplevel)
    echo ${top_path[(ws:/:)-1]}
  fi
}

unpushed () {
  $git cherry -v @{upstream} 2>/dev/null
}

need_push () {
  if [[ $(unpushed) == "" ]]
  then
    echo " "
  else
    echo " with %{$fg[magenta]%}unpushed%{$reset_color%} "
  fi
}

rb_prompt(){
  if (( $+commands[rbenv] ))
  then
    echo "%{$fg_bold[yellow]%}$(rbenv version | awk '{print $1}')%{$reset_color%}"
  else
    echo ""
  fi
}

# This keeps the number of todos always available the right hand side of my
# command line. I filter it to only count those tagged as "+git-repository-name"
# to scope the count by the project I'm looking at.
todo(){
  if (( $+commands[todo.sh] ))
  then
    # num=$(echo $(todo.sh ls +next | wc -l))
    num=$(echo $(todo.sh ls "+$(git_repository_name)" | wc -l))
    let todos=num-2
    if [ $todos != 0 ]
    then
      echo "$todos"
    else
      echo ""
    fi
  else
    echo ""
  fi
}

directory_name(){
  echo "%{$fg_bold[cyan]%}%1/%\/%{$reset_color%}"
}

# export PROMPT=$'\n$(rb_prompt) in $(directory_name) $(git_dirty)$(need_push)\n› '
export PROMPT='%{$fg[blue]%}%n: %{$fg[blue]%}%c %{$fg[white]%}%(!.#.›)%{$reset_color%} '
set_prompt () {
  # export RPROMPT="%{$fg_bold[cyan]%}$(todo)%{$reset_color%}"
  export RPROMPT="%{$fg[cyan]%}%{$reset_color%} $(git_dirty)$(need_push)"
}

precmd() {
  title "zsh" "%m" "%55<...<%~"
  set_prompt
}
