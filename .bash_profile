# Set Paths
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Enable color
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='3;33'

# Add Color Options
PRFL_RED='\033[0;31m'
PRFL_GREEN='\033[0;32m'
PRFL_CYAN='\033[1;30m'
PRFL_YELLOW='\033[1;33m'
PRFL_NOCLR='\e[0m'

# Constants
KALI_VM_NAME='Kali-64'

# General aliases
alias l='ls -al'
alias cd..='cd ../'
alias ..='cd ../'
alias space='diskutil info / | grep "Volume Available Space"'

# Git aliases
alias g='git'
alias gd='git diff'
alias gs='git status'

# Docker container aliases
alias ctf='docker run -it --rm ubuntu-ctf /bin/bash'

# Run Kali Linux in VirtualBox
alias kali="vboxmanage startvm '$KALI_VM_NAME'"

# Docker overrides
# - docker cull - remove all stopped docker containers
# - docker halt - stop all running docker instances and remove them
# - docker prune - remove all stopped docker containers and all images
docker() {
  if [[ $@ == "cull" ]]; then
    echo "Removing all stopped docker containers..."
    docker container prune
  elif [[ $@ == "halt" ]]; then
    docker_instances=$(docker ps -a -q)
    if [ -z "$docker_instances" ]; then
      echo "No running instances found."
    else
      echo "Stopping all docker instances..."
      docker stop $docker_instances && docker rm $docker_instances
    fi
  elif [[ $@ == "prune" ]]; then
    echo "Removing all docker containers and images..."
    docker system prune -a
  else
    command docker "$@"
  fi
}

# NPM overrides
# - npm linked - show all npm linked packages
# - npm redo - remove node_modules folder and run npm install
npm() {
  if [[ $@ == "linked" ]]; then
    if [ -d "node_modules" ]; then
      linked_packages=$(l node_modules/ | grep ^l | awk '{print $9}')
      if [ -z "$linked_packages" ]; then
        echo "${PRFL_CYAN}No modules are linked."
      else
        echo "The following modules are linked:"
        echo "${PRFL_GREEN}${linked_packages}"
      fi
    else
      echo "${PRFL_RED}No node_modules folder found."
    fi
  elif [[ $@ == "redo" ]]; then
    if [ -d "node_modules" ]; then
      echo "Removing node_modules..."
      rm -rf node_modules
    else
      echo "No node_modules folder found."
    fi
    echo "Installing npm packages..."
    npm install
  elif [[ $@ == "clean" ]]; then
    echo -n "${PRFL_YELLOW}Are you sure you'd like to remove all npm-debug.* files ${PRFL_NOCLR}(y/n)? "
    read answer
    if echo "$answer" | grep -iq "^y"; then
        echo "Cleaning up debug files..."
        rm -f npm-debug.*
        echo "${PRFL_GREEN}Done."
    else
        echo No changes made.
    fi
  else
    command npm "$@"
  fi
}

