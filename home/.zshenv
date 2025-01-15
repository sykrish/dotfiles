. "$HOME/.cargo/env"

# Probabliy not intersting to keep
export MANPATH="$HOME/bin/texlive/2022/texmf-dist/doc/man:$MANPATH"
export INFOPATH="$HOME/bin/texlive/2022/texmf-dist/doc/info:$INFOPATH"

export PATH="$HOME/bin/texlive/2022/bin/x86_64-linux:$PATH"
export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH:$HOME/.local/bin"
export META_DATABASE_HOST=mariadb.betty.docker
export SYNAPSE_DB_HOST=mariadb.betty.docker

export ERL_AFLAGS='-kernel shell_history enabled'

# bun
export BUN_INSTALL="$HOME/.bun"
export GOPATH="$HOME/.asdf/installs/golang/1.20.2/packages"

export FZF_DEFAULT_OPTS='--height=60% --preview="head -100 {}" --preview-window=down:40% '
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .gitignore -g ""'
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'

export ZSH="/Users/$USER/.oh-my-zsh"
export EDITOR='nvim'
export PAGER='less'
