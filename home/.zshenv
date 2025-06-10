export ERL_AFLAGS='-kernel shell_history enabled'

export FZF_DEFAULT_OPTS='--height=60% --preview="head -100 {}" --preview-window=down:40% '
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .gitignore -g ""'
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'

export ZSH="/Users/$USER/.oh-my-zsh"
export EDITOR='nvim'
export PAGER='less'

export XDG_CONFIG_HOME="$HOME/.config"
export USER_CONFIG="$HOME/.config"
export HYPR_CONFIG_DIR="$USER_CONFIG/hypr/"
export HYPR_CONFIG="$HYPR_CONFIG_DIR/hyprland.conf"

[ -f $HOME/.env.local ] && . "$HOME/.env.local"
