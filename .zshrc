alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

export EDITOR=nvim
export VISUAL='nvim'

export QT_QPA_PLATFORM=wayland
export QT_QPA_PLATFORMTHEME=qt5ct
export QT_SELECT=5

source ~/.zprofile

# Disable highlight on paste
unset zle_bracketed_paste

GOPATH=$HOME/go  PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

export NVM_DIR="$HOME/.nvm"
export NVM_LAZY_LOAD=true
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

#ctrl-p po defaultu ide na pocetak linije umesto na kraj
bindkey "^P" up-line-or-search
bindkey "^N" down-line-or-search

#aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ll='ls -la --color=auto'
PS1='[\u@\h \W]\$ '

alias open='xdg-open'

# Enable colors and change prompt:
autoload -U colors && colors
# PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Load aliases and shortcuts if existent.
[ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc"
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

#ctrl backspace ctrl del
# bindkey '^H' backward-kill-word
bindkey '^H' vi-backward-kill-word
bindkey '5~' kill-word

#ctrl left/right
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word



source ~/.zsh/catppuccin_macchiato-zsh-syntax-highlighting.zsh
# Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh # 2>/dev/null

ZSH_AUTOSUGGEST_STRATEGY=(completion history)
# source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

#nvm slow load fix
source ~/.zsh/zsh-nvm-lazy-load.plugin.zsh

#mozda ne ovo
# source ~/.zsh/web_search.zsh

# source ~/.zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh     

# bindkey '^N' autosu

eval "$(starship init zsh)"
# zprof

export PATH=$PATH:/home/dusan/.spicetify
