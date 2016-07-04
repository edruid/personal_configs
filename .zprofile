# ~/.zprofile
# zsh_svn-r110

[[ -e "/etc/profile.env" ]] && source /etc/profile.env

umask 022

setopt ALL_EXPORT
if [ "$EUID" = "0" ] || [ "$USER" = "root" ] ; then
		PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:${ROOTPATH}"
else
		PATH="/usr/local/bin:/usr/bin:/bin:${PATH}"
fi

if [[ -d ~/bin ]] ; then
		PATH="${HOME}/bin:${PATH}"
		if [[ -d ~/sbin ]] ; then
				PATH="${HOME}/sbin:${PATH}"
		fi
		if [[ -d ~/man ]] ; then
				MANPATH="${HOME}/man:${MANPATH}"
		fi
		if [[ -d ~/share/man ]] ; then
				MANPATH="${HOME}/share/man:${MANPATH}"
		fi
fi
if [[ -d /opt/local/bin ]] ; then
		PATH="/opt/local/bin:${PATH}"
		if [[ -d /opt/local/sbin ]] ; then
				PATH="/opt/local/sbin:${PATH}"
		fi
		if [[ -d /opt/local/man ]] ; then
				MANPATH="/opt/local/man:${MANPATH}"
		fi
fi

zstyle ':completion:*' special-dirs true

setopt prompt_subst
autoload -Uz vcs_info
zstyle ':vcs_info:*' actionformats '%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f'
zstyle ':vcs_info:*' formats       '%F{5}[%F{6}%b%F{5}]%f'

zstyle ':vcs_info:*' enable git

# or use pre_cmd, see man zshcontrib
vcs_info_wrapper() {
  vcs_info
  if [ -n "$vcs_info_msg_0_" ]; then
    echo "%{$fg[grey]%}${vcs_info_msg_0_}%{$reset_color%}$del"
  fi
}
PROMPT=$'%{\e[32;1m%}%n@%5m%{\e[m%} %{\e[31;1m%}%~%{\e[m%} $(vcs_info_wrapper)\n%1(j:%{\e[33;1m%}:%{\e[32;1m%})[%j]%{\e[m%} %{\e[33;1m%}%T%{\e[m%} %{\e[31m%}%# %{\e[m%}'
RPROMPT=$'%{\e[31m%}%# %{\e[m%}%{\e[33;1m%}%D{%F}%{\e[m%} %0(?:%{\e[32;1m%}:%{\e[31m%})[%?]%{\e[m%}'
HISTSIZE=4096
HISTFILE=~/.zsh_history
SAVEHIST=3072
EDITOR="vim"

LC_CTYPE="sv_SE.utf-8"
LC_NUMERIC="sv_SE.utf-8"
LC_TIME="sv_SE.utf-8"
# . ignoreras vid sortering av tex lsoutput
LC_COLLATE="sv_SE.utf-8"
LC_MONETARY="sv_SE.utf-8"
LC_MESSAGES="en_US.utf-8"
LC_PAPER="sv_SE.utf-8"
LC_NAME="sv_SE.utf-8"
LC_ADDRESS="sv_SE.utf-8"
LC_TELEPHONE="sv_SE.utf-8"
LC_MEASUREMENT="sv_SE.utf-8"
LC_IDENTIFICATION="sv_SE.utf-8"

HAVE_RUN_ZPROFILE=Y

unsetopt ALL_EXPORT

unset MAILCHECK
unset ROOTPATH

if [ "$HAVE_RUN_LOCAL_ZPROFILE" != "Y" ] && [[ -f ~/.zprofile.local ]]; then
  . ~/.zprofile.local
  export HAVE_RUN_LOCAL_ZPROFILE="Y"
fi
