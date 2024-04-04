export ZSH=$HOME/.oh-my-zsh
source $ZSH/oh-my-zsh.sh
source ~/antigen.zsh

HYPHEN_INSENSITIVE="true"
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="%F{tomato}waiting...%f"

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle pip
antigen bundle command-not-found
antigen bundle macos
antigen bundle docker
antigen bundle docker-compose
antigen bundle brew
antigen bundle cp
antigen bundle asdf
antigen bundle z
antigen bundle supercharge
antigen bundle vi-mode

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions

# Load the theme.
antigen theme robbyrussell

# Tell Antigen that you're done.
antigen apply

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

#
# # Path to your oh-my-zsh installation.
# export ZSH="$HOME/.oh-my-zsh"
#
# # Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=$HOME/zsh_custom
#
# # Set name of the theme to load --- if set to "random", it will
# # load a random theme each time oh-my-zsh is loaded, in which case,
# # to know which specific one was loaded, run: echo $RANDOM_THEME
# # See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"
#
# # Which plugins would you like to load?
# # Standard plugins can be found in $ZSH/plugins/
# # Custom plugins may be added to $ZSH_CUSTOM/plugins/
# # Example format: plugins=(rails git textmate ruby lighthouse)
# # Add wisely, as too many plugins slow down shell startup.
# plugins=(
#   macos
#   git
#   docker
#   docker-compose
#   zsh-autosuggestions
#   zsh-completions
#   zsh-syntax-highlighting
#   brew
#   cp
#   asdf
#   z
#   zsh-exa
#   zsh-bat
#   supercharge
#   vi-mode
# )
#
# # Uncomment the following line to use hyphen-insensitive completion.
# # Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"
#
#
# # Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"
#
# # Uncomment the following line to display red dots whilst waiting for completion.
# # You can also set it to another string to have that shown instead of the default red dots.
# # e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# # Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"
#
# source $HOME/.config/zsh/aliases.zsh
# source $HOME/.config/zsh/exports.zsh
#
# source $ZSH/oh-my-zsh.sh
# autoload -U compinit && compinit
#
# # User configuration
#
# # Set personal aliases, overriding those provided by oh-my-zsh libs,
# # plugins, and themes. Aliases can be placed here, though oh-my-zsh
# # users are encouraged to define aliases within the ZSH_CUSTOM folder.
# # For a full list of active aliases, run `alias`.
# #
alias pycharm='open -b com.jetbrains.pycharm'


# # Anaconda
# # https://medium.com/ayuth/install-anaconda-on-macos-with-homebrew-c94437d63a37
# export PATH="/usr/local/anaconda3/bin:$PATH"
#
# # https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-macos#completion-isnt-working
# autoload bashcompinit && bashcompinit
# source $(brew --prefix)/etc/bash_completion.d/az
#
# # >>> conda initialize >>>
# # !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
#         . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
#     else
#         export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# # <<< conda initialize <<<

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

eval "$(pyenv virtualenv-init -)"
# <<< pyenv initialize <<<

export PATH=$PATH:/Users/robin/.pixi/bin
eval "$(pixi completion --shell zsh)"

eval "$(direnv hook zsh)"
