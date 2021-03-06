#!/usr/bin/env zsh

# Load main files.
# echo "Load start\t" $(gdate "+%s-%N")
source "$dotfiles/terminal/startup.sh"
source "$dotfiles/terminal/completion.sh"
source "$dotfiles/terminal/highlight.sh"
# echo "Load end\t" $(gdate "+%s-%N")

# Load local completion files
for file in $dotfiles/etc/completion/* ; do
  #echo "looking at $file"
  if [ -f "$file" ] ; then
    . "$file"
    #echo "loading $file"
  fi
done

autoload -U colors && colors

# Load and execute the prompt theming system.
fpath=("$dotfiles/terminal" $fpath)
autoload -Uz promptinit && promptinit
prompt 'paulmillr'

# Python
python_bin='/Library/Frameworks/Python.framework/Versions/3.8/bin/'
path+=$python_bin

# Python OpenSSL cert
CERT_PATH=$(python3 -m certifi)
SSL_CERT_FILE=${CERT_PATH}
REQUESTS_CA_BUNDLE=${CERT_PATH}

# Heroku
path+=('/usr/local/heroku/bin')

# Ruby (installed from `brew install ruby`)
export PATH=/usr/local/opt/ruby/bin:$PATH;

# Virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/Library/Frameworks/Python.framework/Versions/3.8/bin/python3
export VIRTUALENVWRAPPER_VIRTUALENV=$python_bin'/virtualenv'
source $python_bin'/virtualenvwrapper.sh'

# Android/react native dev
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Node Version Manager (nvm)
mkdir -p ~/.nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
# We have the nvm bash completion already from ../terminal/completion/_nvm
#[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# To get the latest node LTS and use it by default:
#   nvm install --lts && nvm use --lts && nvm alias default node

# Postgres 11 install helper, not necessary on latest `brew install postres`
path+=('/usr/local/opt/postgresql@11/bin')

# Set global git ignore up
git config --global core.excludesfile '~/.gitignore'

# After modifications, export path for other people to use
export PATH

# Don't share history between terminal tabs
unsetopt inc_append_history
unsetopt share_history

# ==================================================================
# = Aliases =
# ==================================================================
alias killpycs='find . -name "*.pyc" -delete'
alias ls='ls -AGhl'
alias pycharm='open -na "PyCharm.app" --args "$@"'
alias dstop='docker stop $(docker ps -qa)'
alias dstart='docker-compose up -d'

# ==================================================================
# = Functions =
# ==================================================================

# Better find(1)
function ff() {
  find . -iname "*${1:-}*"
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
