setopt prompt_subst
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
autoload bashcompinit && bashcompinit
autoload -Uz compinit
compinit

# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history 
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify


export SUDO_EDITOR="nvim"
export EDITOR=nvim
export LC_ALL=en_US.UTF-8
export LC_TIME=en_US.UTF-8

# Pour colorer eza, tree, etc... (parfait pour la couleur violet)
export LS_COLORS="$(vivid generate dracula)"



source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh


# export PATH="/sbin:$PATH"
export PATH="/home/for/.local/bin:$PATH"
export PATH="/home/for/.atuin/bin/:$PATH"
export PATH="$HOME/.pyenv/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export TODO_DB_PATH=$HOME/.config/td/todo.json
export PATH="$HOME/.pyenv/versions/3.11.11/bin:$PATH"
export PATH="/home/for/.pyenv/shims/auto-cpufreq:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"


alias sudo='sudo '
alias nv='nvim'
alias sn='shutdown now'
alias rb='reboot'
alias rm="rm -i"


alias py="python3"
alias todo="td"
alias cat=bat
alias less="bat --paging always"
alias du="dust -r"
alias yzai="y"
alias yz="y"
# alias ya="y"

alias l="eza -l --icons --git --group-directories-first"
alias ls="l"
alias ll="l"
alias la='eza -al --git --group-directories-first --icons=always'
alias lt="eza --tree --level=2 --icons --git"

# ~~~~~~~(tend à être obsolète)~~~~~~~~~~~
alias "ls -ll"="ll"
alias "ls -la"="la"
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

alias lg="lazygit"

alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# bindkey '^[[P' delete-char

bindkey "^[[3~" delete-char
bindkey "^[[1;3D" backward-word    # Alt + flèche gauche
bindkey "^[[1;3C" forward-word     # Alt + flèche droite
bindkey "^[[1;5D" backward-word    # Ctrl + flèche gauche
bindkey "^[[1;5C" forward-word     # Ctrl + flèche droite

# Fonction pour vérifier si la commande commence par "ssh"
function sshc() {
  # Lancer ssh-agent si ce n'est pas déjà fait
  if [ -z "$SSH_AUTH_SOCK" ]; then
    keychain -q id_ed25519  
    source ~/.keychain/archlinux-sh
  fi
  # Appeler la commande ssh originale
  command ssh "$@"
}

f() { echo "$(find . -type f -not -path '*/go*' | fzf)" | xclip -selection clipboard }
fcd() { cd "$(find . -type d -not -path '*/go*' | fzf)" && l; }
fv() { nvim "$(find . -type f -not -path '*/go*' | fzf)" }
git() {
  if [[ "$1" == "log" || "$1" == "glog" ]]; then
    shift
    # command git-graph --format "$(echo "%h \033[90m%ad\033[0m \033[34m%an\033[0m →  %s")" 
    
    # avec retour à la ligne 
    # command git-graph --format "$(echo "%h \033[90m%ad\033[0m \033[34m%an\033[0m \033[31m→ \033[0m %s%n ")"    

    # sans retour à la ligne 
    command git-graph --format "$(echo "%h \033[90m%ad\033[0m \033[34m%an\033[0m \033[31m→ \033[0m %s%n")"    
  elif [[ "$1" == "modif" ]]; then
    command git diff --stat HEAD~1 HEAD
  else
    command git "$@"
  fi
}

# ********************* Pour projet PR105 ****************************
export GSL_PATH="/home/for/Documents/s6/projets/gsl-2.8/install"

# ********************************************************************

# ========= alacritty terminal in the same directory as the last terminal used
export TERMINAL_LAST_DIR="$HOME"

update_last_dir() {
    echo "$PWD" > "$HOME/.last_dir"
}

chpwd() {

    if [[ "$PWD" == "/home/for/Documents/s6/projets/pr105-coursidor-26243" ]]; then
        td
    elif [[ "$PWD" == "/home/for/Documents/s6/projets/pr106-actor-26243" ]]; then
        td
    fi
    update_last_dir;
}  # Appelé automatiquement après chaque `cd`

# Charger le dernier répertoire au lancement
if [ -f "$HOME/.last_dir" ]; then
    export TERMINAL_LAST_DIR="$(cat "$HOME/.last_dir")"
fi


if [[ "$XDG_SESSION_TYPE" == "x11" ]]; then
    alias firefox='firefox -P default-release'
elif [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
    alias firefox='firefox -P hyprland'
fi



export PS1='[\u@\h] \W :: $(git branch --show-current 2>/dev/null)> '
eval "$(zoxide init zsh)"
eval "$(atuin init zsh --disable-up-arrow)"
eval "$(starship init zsh)"
# export STARSHIP_CONFIG=~/.config/starship/customstarship_purple.toml
export STARSHIP_CONFIG=~/.config/starship/customstarship.toml
# export STARSHIP_CONFIG=~/.config/starship/starship.toml
# export STARSHIP_CONFIG=~/.config/starship/templateFromInternet.toml

ZSH_AUTOSUGGEST_MANUAL_REBIND=0

precmd() {
  echo -ne "\033]0;Alacritty: ${PWD/#$HOME/~}\007"
}

function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}
