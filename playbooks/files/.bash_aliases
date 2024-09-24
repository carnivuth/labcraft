# function for auto disown processes
startAndDisown() {
    program="$1"
    shift
    "$program" "$@" >> /tmp/"$program".out 2>&1 & disown $!
}

#autodisown aliases
alias d='startAndDisown'
alias mpv='startAndDisown mpv'

#ls aliases
alias ls='ls --color=auto '
alias ll='ls --color=auto -pl'
alias la='ls --color=auto -pa'
alias lla='ls --color=auto -pla'

# git
alias G='git'

# clear
alias c='clear'

# grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# diff
alias diff='diff --color=auto'

# ip
alias ip='ip --color=auto'

# du
alias du='du -h'
#
# df
alias df='df -h'

# vim
alias v='vim'
alias vml='vim'
