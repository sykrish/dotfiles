export ERL_AFLAGS='-kernel shell_history enabled'

export FZF_DEFAULT_OPTS='--height=60% --preview="head -100 {}" --preview-window=down:40% '
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .gitignore -g ""'
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'

export ZSH="/Users/$USER/.oh-my-zsh"
export EDITOR='nvim'
export PAGER='less'

[ -f $HOME/.env.local ] && . "$HOME/.env.local"
