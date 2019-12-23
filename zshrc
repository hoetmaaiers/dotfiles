# Manually set your 'PATH' environment variable
export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/home/houdmeyr/.local/bin:/home/houdmeyr/.yarn/bin:$HOME/anaconda3/bin/:$PATH"

# =======================================================================
# Nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm


# # place this after nvm initialization!
# autoload -U add-zsh-hook
# load-nvmrc() {
#   if [[ -f .nvmrc && -r .nvmrc ]]; then
#     nvm use
#   elif [[ $(nvm version) != $(nvm version default)  ]]; then
#     echo "Reverting to nvm default version"
#     nvm use default
#   fi
# }
# add-zsh-hook chpwd load-nvmrc
# load-nvmrc
# =======================================================================

# load zgen
source "${HOME}/.zgen/zgen.zsh"

# Check if there's no init script
if ! zgen saved; then
  # plugins
  zgen oh-my-zsh
  zgen oh-my-zsh plugins/git
  zgen oh-my-zsh plugins/npm
  # zgen oh-my-zsh plugins/yarn
  zgen oh-my-zsh plugins/wd
  zgen oh-my-zsh plugins/docker
  zgen oh-my-zsh plugins/docker-compose
  zgen load zsh-users/zsh-syntax-highlighting
  zgen load zsh-users/zsh-history-substring-search
  # zgen load webyneter/docker-aliases
  # zgen load gusaiani/elixir-oh-my-zsh
  # zgen load peterhurford/git-it-on.zsh

  # theme
  # zgen oh-my-zsh themes/robbyrussel
  zgen oh-my-zsh themes/refined

  # generate the init script from plugins above
  zgen save
fi

# # Load oh my zsh
# source $ZSH/oh-my-zsh.sh

alias zshconfig="vim ~/.zshrc"
alias zshconfig_load="source ~/.zshrc"
# alias dc="docker-compose"
# alias docker_remove_none_images="docker rmi $(docker images | grep "^<none>" | awk '{print $3}')"




# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/houdmeyr/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/houdmeyr/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/houdmeyr/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/houdmeyr/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

