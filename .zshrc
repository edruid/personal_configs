# ~/.zshrc
# zsh_svn-r110

setopt NO_PROMPT_CR
setopt NO_BEEP
setopt AUTO_MENU
setopt COMPLETE_IN_WORD
setopt EXTENDED_GLOB
setopt AUTOCD
setopt INTERACTIVE_COMMENTS
setopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt SHARE_HISTORY

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
zstyle ':completion:*' special-dirs true

autoload -U compinit
compinit -d ~/.zcompdump.`hostname`

bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey '^r' history-incremental-search-backward
bindkey '^y' yank
bindkey '^t' delete-word
bindkey '^x' copy-prev-shell-word
bindkey '^z' vi-undo-change
bindkey "\e[A" history-beginning-search-backward  # up
bindkey "\e[B" history-beginning-search-forward   # down
bindkey "\e[C" vi-forward-char                    # right
bindkey "\e[D" vi-backward-char                   # left
bindkey "\e[2~" quoted-insert                     # insert
bindkey "\e[3~" delete-char                       # delete
bindkey "\e[5~" history-beginning-search-backward # pgup
bindkey "\e[6~" history-beginning-search-forward  # pgdn
bindkey '^[[1;5C' emacs-forward-word
bindkey '^[[1;5D' emacs-backward-word
#bindkey "\e[7~" beginning-of-line
#bindkey "\e[8~" end-of-line
#bindkey "\e[H" beginning-of-line
#bindkey "\e[F" end-of-line
#bindkey "\eOH" beginning-of-line
#bindkey "\eOF" end-of-line
#bindkey "\eOd" backward-word
#bindkey "\eOc" forward-word

alias py="python -m IPython || python"
alias py3="python3 -m IPython || python3"
alias find='noglob find'

update-zsh() {
	emulate -L zsh

	if [[ x"$1" = x"" ]]; then
		BAH_PATH="${HOME}/bah/"
	else
		BAH_PATH=$1
	fi
	echo "  "BAH_PATH=${BAH_PATH}

	echo "  "Syncing bah-repo.
	svn up ${BAH_PATH}
	SVN_REV=$(svn info ${BAH_PATH}|grep Revision|cut -d' ' -f2)
	echo "  "SVN_REV=${SVN_REV}
	echo "  "Updating zsh-config.
	sed -e "s/^# zsh_svn$/# zsh_svn-r${SVN_REV}/" ${BAH_PATH}/configs/zshrc > ~/.zshrc_ && \
		mv ~/.zshrc_ ~/.zshrc && echo .zshrc updated.
	sed -e "s/^# zsh_svn$/# zsh_svn-r${SVN_REV}/" ${BAH_PATH}/configs/zprofile > ~/.zprofile_ && \
		mv ~/.zprofile_ ~/.zprofile && echo .zprofile updated.
	rm ~/.zcompdump.* 2> /dev/null && echo removed old .zcompdump.
	echo "  "Recompiling configs.
	zcompile ~/.zprofile
	zcompile ~/.zshrc
	zcompile ~/.zprofile.local
	zcompile ~/.zshrc.local
}

precmd() {
	if [ "$TERM" != "linux" ]; then
		echo -ne "\033]0;${USER}@${HOST}: ${PWD}\007"
	fi
}

shell-backward-kill-word() {
	emulate -L zsh
	local words word spaces
	words=(${(z)LBUFFER})
	word=$words[-1]
	if [[ -n ${word[2,-2]//[^\/]} ]]; then
		word=${word##*/?}o
	fi
	spaces=-1
	while [[ $LBUFFER[$spaces] == " " ]]; do
			(( spaces-- ))
	done
	#killring=("$CUTBUFFER" "${(@)killring[1,-2]}")
	#CUTBUFFER=$LBUFFER[$((-$#word + $spaces + 1)),-1]
	LBUFFER=$LBUFFER[0,$((-$#word + $spaces))]
}
zle -N shell-backward-kill-word
bindkey '^w' shell-backward-kill-word

if [ "$HAVE_RUN_ZPROFILE" != "Y" ]; then
  . ~/.zprofile
fi
if [[ -f ~/.zshrc.local ]]; then
  . ~/.zshrc.local
fi
