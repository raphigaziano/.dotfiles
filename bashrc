# bashrc
#
# Shell settings & utilis
#
# raphigaziano <r.gaziano@gmail.com>
####################################

### General ###

# Set VIM Mode
set -o vi

# Custom prompt
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h \[\033[01;33m\]\w \n\[\033[01;34m\]\$\[\033[00m\] '

# Activate autojump
. /usr/share/autojump/autojump.sh
# Autojump config
export AUTOJUMP_AUTOCOMPLETE_CMDS='v vim'

### ENV VARS ###

export TERM=xterm-256color

export EDITOR=vim
export PATH=$PATH:~/bin:~/.local/bin

export GITHUBHOME=https://github.com/raphigaziano  # Git Home
export DEVDIR=~/dev                                # Dev dir

# virtualenvwrapper settings
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$DEVDIR

source $HOME/.local/bin/virtualenvwrapper.sh

# Source personal autocompletion script
source $HOME/bin/.autocompletions.sh

### Utils, shortcuts ###

# From http://sametmax.com/a-linterieur-de-mon-bashrc/
extract () {
    if [ -f $1 ]
    then
        case $1 in
            (*.7z)      7z x $1 ;;
            (*.lzma)    unlzma $1 ;;
            (*.rar)     unrar x $1 ;;
            (*.tar)     tar xvf $1 ;;
            (*.tar.bz2) tar xvjf $1 ;;
            (*.bz2)     bunzip2 $1 ;;
            (*.tar.gz)  tar xvzf $1 ;;
            (*.gz)      gunzip $1 ;;
            (*.tar.xz)  tar Jxvf $1 ;;
            (*.xz)      xz -d $1 ;;
            (*.tbz2)    tar xvjf $1 ;;
            (*.tgz)     tar xvzf $1 ;;
            (*.zip)     unzip $1 ;;
            (*.Z)       uncompress ;;
            (*) echo "don't know how to extract '$1'..." ;;
        esac
    else
        echo "Error: '$1' is not a valid file!"
        exit 0
    fi
}

# Syntax higlighted less
function cless {
    # NOTE: Requires pygments.
    pygmentize -f terminal256 -O style=monokai -g "$@" | less -R
}

# mkdir and cd into into it
function cdmkdir () {
    mkdir -p "$@" && eval cd "\"\$$#\"";
}

# Cd into project dir and activate its virtualenv
function project {
    workon $1
    cd $DEVDIR/$1
}

# Fun crap \o/

function rcowsay() {
    cowsay_dir=/usr/share/cowsay/cows
    # Pick a random cowsay file
    cowsay_file=$(ls $cowsay_dir | sort -R | tail -1)
    cowsay -f $cowsay_file $*
    echo
}
function cow_fortune {
    fortune | rcowsay
}

### Aliases ###

# Repeat last cmd as super user
alias plz="sudo !!"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

# Pip alias
alias pipusr='pip install --user'
# Git aliases

alias ga='git add'
alias gp='git push'
alias gl='git log'
alias gs='git status'
alias gd='git difftool'
alias gdc='git difftool --cached'
alias gm='git commit -m'
alias gma='git commit -am'
alias gb='git branch'
alias gc='git checkout'
alias gra='git remote add'
alias grr='git remote rm'
alias gpu='git pull'
alias gcl='git clone'

# Shortcut from cloning from a personal repo
function clone {
    git clone $GITHUBHOME/$1
}

# Quickie vim

# Compute filenames based on the passed extension, and call vim with those.
# This function should not be called manually:
# Set up an alias for it instead (see below).
function _vim_filext {
    # BAD NAME
    if [[ -z "$2" ]]; then
        echo "Give me a filename to work with!"
        return 1
    fi
    ext=$1
    shift
    res=()
    for f in $*; do
        res+=("$f.$ext")
    done
    vim ${res[@]}
}

# Shortcut for creating a new python package
function mkpypkg {
    mkdir -p $1
    touch "$1/__init__.py"
}

alias v="vim"
alias vi="vim"
alias vpy="_vim_filext 'py'"
alias vhtml="_vim_filext 'html'"
alias vcss="_vim_filext 'css'"
alias vjs="_vim_filext 'js'"
alias vc="_vim_filext 'c'"
alias vcpp="_vim_filext 'cpp'"
alias vh="_vim_filext 'h'"

alias ll="ls -lh"

# Check gmail account
# (depends on ,feedreadr.py)
# gmail feed for registration:
# https://mail.google.com/mail/feed/atom
alias cgmail=',feedreadr.py fetch https://mail.google.com/mail/feed/atom -u r.gaziano'
# open chromium on gmail
alias ggmail='chromium-browser https://mail.google.com/mail/?shva=1#inbox'

# Run a simple http server in cwd
alias serve="python -m SimpleHTTPServer"

# Django-pylint
alias djlint="pylint --generated-members=objects,DoesNotExist"

# Grep python processes
alias pyps='ps aux | grep python'

# Purge python .pyc files
alias killpyc='find . -name "*.pyc" -delete'
# Purge vim swap files
alias killvim='find . -name "*.sw[op]" -delete'

### Startup ###

# cow_fortune
