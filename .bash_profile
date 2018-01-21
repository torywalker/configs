# Enable color
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='3;33'

# General aliases
alias l='ls -al'
alias cd..='cd ../'
alias ..='cd ../'
alias space='diskutil info / | grep "Volume Available Space"'

# Git aliases
alias g='git'
alias gs='git status'
alias gd='git diff'

# Run Kali Linux in Docker
alias kali="docker run -t -i kalilinux/kali-linux-docker /bin/bash"

# Docker overrides
# - docker cull - remove all docker containers
# - docker halt - stop all running docker instances
docker() {
  if [[ $@ == "cull" ]]; then
    echo "Removing docker containers..."
    docker ps -a | grep Exit | cut -d ' ' -f 1 | xargs docker rm
  elif [[ $@ == "halt" ]]; then
    docker_instances=$(docker ps -a -q)
    if [ -z "$docker_instances" ]; then
      echo "No running instances found."
    else  
      echo "Stopping all docker instances..."
      docker stop $docker_instances && docker rm $docker_instances
    fi
  else
    command docker "$@"
  fi
}

# NPM overrides
# - npm redo - remove node_modules folder and run npm install
# - npm linked - show all npm linked packages
npm() {
  if [[ $@ == "redo" ]]; then
    if [ -d "node_modules" ]; then
      echo "Removing node_modules..."
      rm -rf node_modules
      echo "Installing npm packages..."
      npm install
    else
      echo "No node_modules folder found."
    fi
  elif [[ $@ == "linked" ]]; then
    if [ -d "node_modules" ]; then
      linked_packages=$(l node_modules/ | grep ^l | awk '{print $9}')
      if [ -z "$linked_packages" ]; then
        echo "No modules are linked."
      else     
        echo "The following modules are linked:"
        echo $linked_packages
      fi
    else
      echo "No node_modules folder found."
    fi
  else
    command npm "$@"
  fi
}

