# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
#[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
#shopt -s checkwinsize

### alias ###
alias ll='ls -lG'
alias la='ls -GAalth'
alias l='ls -GCF'
alias lt='ls -Glth'
alias grep='grep --color=auto'
alias tree='tree -C'
alias md5sum='md5 -r'
alias cdiff='~/local/colordiff/colordiff.pl | less -R'
# alias for git
alias git-ci='git commit'
alias git-log='git log'
alias git-stat='git status'
alias git-diff='git diff'
alias git-co='git checkout'
alias git-pull='git pull'
alias git-push='git push'
alias git-clone='git clone'
alias git-gm="git status | grep modified"
# alias for gcc
alias gw='gcc -g -O2 -Wall -fno-strict-aliasing -Wno-deprecated-declarations -D_THREAD_SAFE'
alias gt='gcc -g -finline-functions -Wall -Winline -pipe'
alias gco='gcc -framework Foundation'


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# color man
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

## color less
#export PAGER="/usr/bin/less -s"
#export BROWSER="$PAGER"
#export LESS_TERMCAP_mb=$'\E[01;34m'
#export LESS_TERMCAP_md=$'\E[01;34m'
#export LESS_TERMCAP_me=$'\E[0m'
#export LESS_TERMCAP_se=$'\E[0m'
#export LESS_TERMCAP_so=$'\E[01;44;33m'
#export LESS_TERMCAP_ue=$'\E[0m'
#export LESS_TERMCAP_us=$'\E[01;33m'
PAGER='less -X -M' 
export LESS=' -R '

export EDITOR=vim
export PATH=$HOME/local/bin:$PATH:/usr/local/mysql/bin

# some function
function _memtop()
{
    num=$1
    if ((num > 0)) 
    then
        num=$num
    else
        num=30
    fi  
    ps aux | sort -k4nr | head  -n $num    
}
alias memtop=_memtop

function _urlencode()
{
    argc=$#
    if ((argc > 0))
    then
        php $HOME/local/bin/url.php encode $*
    else
        echo "Need more arguments..."
    fi
}
alias urlencode=_urlencode

function _urldecode()
{
    argc=$#
    if ((argc > 0))
    then
        php $HOME/local/bin/url.php decode $*
    else
        echo "Need more arguments..."
    fi
}
alias urldecode=_urldecode

## Parses out the branch name from .git/HEAD:
find_git_branch () {
    local dir=. head
    until [ "$dir" -ef / ]; do
        if [ -f "$dir/.git/HEAD" ]; then
            head=$(< "$dir/.git/HEAD")
            if [[ $head = ref:\ refs/heads/* ]]; then
                git_branch=" → ${head#*/*/}"
            elif [[ $head != '' ]]; then
                git_branch=" → (detached)"
            else
                git_branch=" → (unknow)"
            fi
            return
        fi
        dir="../$dir"
    done
    git_branch=''
}
PROMPT_COMMAND="find_git_branch; $PROMPT_COMMAND"
# Here is bash color codes you can use
  black=$'\[\e[1;30m\]'
    red=$'\[\e[1;31m\]'
  green=$'\[\e[1;32m\]'
 yellow=$'\[\e[1;33m\]'
   blue=$'\[\e[1;34m\]'
magenta=$'\[\e[1;35m\]'
   cyan=$'\[\e[1;36m\]'
  white=$'\[\e[1;37m\]'
 normal=$'\[\e[m\]'

# for gcc
# 这块的覆盖技术没有用好
# 应该把用户的放到最前面
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/local/lib:/usr/local/lib
C_INCLUDE_PATH=$C_INCLUDE_PATH:/usr/local/include:$HOME/local/include:/Developer/SDKs/MacOSX10.5.sdk/usr/include
export C_INCLUDE_PATH
LIBRARY_PATH=$LIBRARY_PATH:/usr/local/lib:$HOME/local/lib:/Developer/SDKs/MacOSX10.5.sdk/usr/lib
export LIBRARY_PATH
LD_RUN_PATH=$LD_RUN_PATH:/usr/local/bin:$HOME/local/bin
export LD_RUN_PATH
DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:/usr/local/lib:$HOME/local/lib
export DYLD_LIBRARY_PATH

#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u\[\033[00m\]\[\033[31;40m\]@\[\033[00m\]\[\033[36;40m\]\h\[\033[00m\]:\[\033[35;40m\]\w\[\033[00m\]\$ '
PS1="${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\[\033[00m\]\[\033[31;40m\]@\[\033[00m\]\[\033[36;40m\]\h\[\033[00m\]:\[\033[35;40m\]\w\[\033[00m\]$yellow\$git_branch$white\$ $normal"
