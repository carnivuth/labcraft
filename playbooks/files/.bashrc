#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#include bas_aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# set editor and visual variables
export EDITOR='vim'
export VIUSUAL='vim'

# set PS1 variable
BLUE6="\[$(tput setaf 6)\]"
BLUE21="\[$(tput setaf 21)\]"
RESET="\[$(tput sgr0)\]"
PS1="[${BLUE6}\u@\h${RESET}:${BLUE21}\w${RESET}]"

# setup default fzf options
export FZF_DEFAULT_OPTS='--cycle --bind "tab:toggle-up,btab:toggle-down"'
