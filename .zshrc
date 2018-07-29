autoload -U colors

export ZSH="$HOME/.oh-my-zsh"


plugins=(
    git
)


#
# History
#

export HISTSIZE=100000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE

#
# Options
#

setopt autocd               # .. is shortcut for cd .. (etc)
setopt autoparamslash       # tab completing directory appends a slash
setopt autopushd            # cd automatically pushes old dir onto dir stack
setopt clobber              # allow clobbering with >, no need to use >!
setopt correct              # command auto-correction
setopt correctall           # argument auto-correction
setopt noflowcontrol        # disable start (C-s) and stop (C-q) characters
setopt nonomatch            # unmatched patterns are left unchanged
setopt histignorealldups    # filter duplicates from history
setopt histignorespace      # don't record commands starting with a space
setopt histverify           # confirm history expansion (!$, !!, !foo)
setopt ignoreeof            # prevent accidental C-d from exiting shell
setopt interactivecomments  # allow comments, even in interactive shells
setopt printexitvalue       # for non-zero exit status
setopt pushdignoredups      # don't push multiple copies of same dir onto stack
setopt pushdsilent          # don't print dir stack after pushing/popping
setopt sharehistory         # share history across shells

#
# Bindings
#

#bindkey -e # emacs bindings, set to -v for vi bindings
#
#autoload history-search-end
#zle -N history-beginning-search-backward-end history-search-end
#zle -N history-beginning-search-forward-end history-search-end
#bindkey "\e[A" history-beginning-search-backward-end  # cursor up
#bindkey "\e[B" history-beginning-search-forward-end   # cursor down
#
#autoload -U select-word-style
#select-word-style bash # only alphanumeric chars are considered WORDCHARS
#
#autoload -U edit-command-line
#zle -N edit-command-line
#bindkey '^x^x' edit-command-line

#bindkey ' ' magic-space # do history expansion on space
#
## Replace standard history-incremental-search-{backward,forward} bindings.
## These are the same but permit patterns (eg. a*b) to be used.
#bindkey "^r" history-incremental-pattern-search-backward
#bindkey "^s" history-incremental-pattern-search-forward

# Make CTRL-Z background things and unbackground them.
function fg-bg() {
  if [[ $#BUFFER -eq 0 ]]; then
    fg
  else
    zle push-input
  fi
}
zle -N fg-bg
bindkey '^Z' fg-bg


#
# Other
#
source $ZSH/oh-my-zsh.sh
source $HOME/.zsh/aliases
source $HOME/.zsh/colors
source $HOME/.zsh/theme

#
# Third-party
#

#
# Hooks
#

#autoload -U add-zsh-hook

function set-tab-and-window-title() {
  emulate -L zsh
  local CMD="${1:gs/$/\\$}"
  print -Pn "\e]0;$CMD:q\a"
}

function update-window-title-precmd() {
  emulate -L zsh
  set-tab-and-window-title `history | tail -1 | cut -b8-`
}
#add-zsh-hook precmd update-window-title-precmd

function update-window-title-preexec() {
  emulate -L zsh
  setopt extended_glob

  # skip ENV=settings, sudo, ssh; show first distinctive word of command;
  # mostly stolen from:
  #   https://github.com/robbyrussell/oh-my-zsh/blob/master/lib/termsupport.zsh
  set-tab-and-window-title ${2[(wr)^(*=*|mosh|ssh|sudo)]}
}
#add-zsh-hook preexec update-window-title-preexec

typeset -F SECONDS
function record-start-time() {
  emulate -L zsh
  ZSH_START_TIME=${ZSH_START_TIME:-$SECONDS}
}

#add-zsh-hook preexec record-start-time

function report-start-time() {
  emulate -L zsh
  if [ $ZSH_START_TIME ]; then
    local DELTA=$(($SECONDS - $ZSH_START_TIME))
    local DAYS=$((~~($DELTA / 86400)))
    local HOURS=$((~~(($DELTA - $DAYS * 86400) / 3600)))
    local MINUTES=$((~~(($DELTA - $DAYS * 86400 - $HOURS * 3600) / 60)))
    local SECS=$(($DELTA - $DAYS * 86400 - $HOURS * 3600 - $MINUTES * 60))
    local ELAPSED=''
    test "$DAYS" != '0' && ELAPSED="${DAYS}d"
    test "$HOURS" != '0' && ELAPSED="${ELAPSED}${HOURS}h"
    test "$MINUTES" != '0' && ELAPSED="${ELAPSED}${MINUTES}m"
    if [ "$ELAPSED" = '' ]; then
      SECS="$(print -f "%.2f" $SECS)s"
    elif [ "$DAYS" != '0' ]; then
      SECS=''
    else
      SECS="$((~~$SECS))s"
    fi
    ELAPSED="${ELAPSED}${SECS}"
    local ITALIC_ON=$'\e[3m'
    local ITALIC_OFF=$'\e[23m'
    export RPROMPT="%F{cyan}%{$ITALIC_ON%}${ELAPSED}%{$ITALIC_OFF%}%f $RPROMPT_BASE"
    unset ZSH_START_TIME
  else
    export RPROMPT="$RPROMPT_BASE"
  fi
}

#add-zsh-hook precmd report-start-time

#add-zsh-hook precmd bounce

function auto-ls-after-cd() {
  emulate -L zsh
  # Only in response to a user-initiated `cd`, not indirectly (eg. via another
  # function).
  if [ "$ZSH_EVAL_CONTEXT" = "toplevel:shfunc" ]; then
    ls -a
  fi
}
#add-zsh-hook chpwd auto-ls-after-cd

# for prompt
#add-zsh-hook precmd vcs_info

# adds `cdr` command for navigating to recent directories
#autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
#add-zsh-hook chpwd chpwd_recent_dirs

# enable menu-style completion for cdr
zstyle ':completion:*:*:cdr:*:*' menu selection

# fall through to cd if cdr is passed a non-recent dir as an argument
zstyle ':chpwd:*' recent-dirs-default true

# Local and host-specific overrides.

#LOCAL_RC=$HOME/.zshrc.local
#test -f $LOCAL_RC && source $LOCAL_RC
#
#DEV_RC=$HOME/.zsh/host/dev-star
#if [ $(hostname -s) =~ '^dev(vm)?[[:digit:]]+' ]; then
#  test -f $DEV_RC && source $DEV_RC
#fi
#
#HOST_RC=$HOME/.zsh/host/$(hostname -s)
#test -f $HOST_RC && source $HOST_RC

#
# Plug-ins
#

#source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=59'

# Uncomment this to get syntax highlighting:
# source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#
# /etc/motd
#

#if [ -e /etc/motd ]; then
#  if ! cmp -s $HOME/.hushlogin /etc/motd; then
#    tee $HOME/.hushlogin < /etc/motd
#  fi
#fi
