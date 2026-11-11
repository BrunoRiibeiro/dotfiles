# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# -- Environment
#
# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export EDITOR='vi'
export MANPAGER='less'
export PAGER='less'
export PATH
export TZ='America/Sao_Paulo'
export VISUAL='vi'

# Support colors in less
export GROFF_NO_SGR=1
export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;31m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[1;33;44m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[4;1;32m'
export LESS_TERMCAP_mr=$'\e[7m'
export LESS_TERMCAP_mh=$'\e[2m'
export LESS_TERMCAP_ZN=$'\e[74m'
export LESS_TERMCAP_ZV=$'\e[75m'
export LESS_TERMCAP_ZO=$'\e[73m'
export LESS_TERMCAP_ZW=$'\e[75m'


# Detect whether vimx is available (Fedora dnf); otherwise, use vim.
command -v vimx &> /dev/null && VIM=vimx || VIM=vim

# Aliases
alias clip='xclip -selection clipboard'
alias down='shutdown now'
alias ew='emacs -nw'
alias gl='glow -s light -t -m'
alias la='ls -A'
alias ll='ls -Glh'
alias ls='ls --color=auto'
alias vi='$VIM'
alias view='$VIM -R'
[[ $VIM != 'vim' ]] && alias vim='$VIM'


# Open vim-ai directly on the AIChat tab
ai() {
	$VIM -c 'AIChat' -c 'tabonly'
}

prompt-init() {
	local reset=$'\e[0m'
	local bold=$'\e[1m'
	local green=$'\e[32m'
	local blue=$'\e[34m'

	# Construct the prompt:
	# <user> @ <hostname> : <cwd> <$|#>

	# username @ hostname :
	PS1="\[$green\]\[$bold\]\u@\h\[$reset\]:"

	# cwd
	PS1+="\[$blue\]\w\[$reset\]"

	# prompt character
	PS1+="\$ "
}

prompt-init

# upload a file to my personal CDN
cdn() {
	local file=$1
	local bname=${file##*/}
	local srht_token=$(awk -F'"' '/access-token/ {print $2}' ~/.config/hut/config)

	[[ -n $file && -n $bname && -n $srht_token ]] || return 1

	local url
	printf -v url '%(%Y/%m/%d)T/%s' -1 "$bname"
	local remote_path="./cdn/$url"
	local domain="cdn.ribeiro.sh"

	rsync -avh --mkpath --progress --ignore-existing -- \
		"$file" "chococino:$remote_path" || return 1

	ssh chococino "tar -C ${remote_path%/$url} -czf - ." |
		curl --fail-with-body --show-error --silent \
		--oauth2-bearer "$srht_token" -F content=@- \
		"https://pages.sr.ht/publish/$domain" > /dev/null || return 1

	echo "https://$domain/$url"
}
