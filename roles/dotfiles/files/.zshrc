autoload -U colors

export ZSH="$HOME/.oh-my-zsh"
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
ZSH_THEME=agnoster


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
# Other
#
source $ZSH/oh-my-zsh.sh
source $HOME/.zsh/aliases
source $HOME/.zsh/bindings
source $HOME/.zsh/colors
#source $HOME/.zsh/theme
source $HOME/.zsh/functions
source $HOME/.zsh/corrections
source $HOME/.zsh/hooks

# Local and host-specific overrides.

LOCAL_RC=$HOME/.zshrc.local
test -f $LOCAL_RC && source $LOCAL_RC
#
#DEV_RC=$HOME/.zsh/host/dev-star
#if [ $(hostname -s) =~ '^dev(vm)?[[:digit:]]+' ]; then
#  test -f $DEV_RC && source $DEV_RC
#fi
#
#HOST_RC=$HOME/.zsh/host/$(hostname -s)
#test -f $HOST_RC && source $HOST_RC


#
# Third-party
#
source $HOME/.st1/vendor/docker-cli/contrib/completion/zsh/_docker


#
# Plug-ins
#

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=59'

# syntax highlighting:
source ~/.zsh/zsh-syntax-hightlighting/zsh-syntax-highlighting.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
bindkey '^P' fzf-file-widget
