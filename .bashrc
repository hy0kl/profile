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
# svn
alias svn-st='svn st | grep ^M'
alias svn-log='svn log -v --limit 5'

# pro
alias ll='ls -lG'
alias la='ls -GAalth'
alias l='ls -GCF'
alias lt='ls -Glth'
alias tf='tail -f'
alias grep='grep --color=auto'
alias tree='tree -C'
alias md5sum='md5 -r'
alias cdiff='~/local/colordiff/colordiff.pl | less -R'
alias rscp='rsync -v -P -e ssh'

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

export SVN_EDITOR=vim
export EDITOR=vim

export PATH=$HOME/local/bin:/usr/local/mysql/bin:$PATH

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

# for gcc {
# 服务器端的覆盖技术
LD_LIBRARY_PATH=$HOME/local/lib:/usr/local/lib:/usr/lib
export LD_LIBRARY_PATH

C_INCLUDE_PATH=$HOME/local/include:/usr/local/include:/usr/include
export C_INCLUDE_PATH

LIBRARY_PATH=$HOME/local/lib:/usr/local/lib:/usr/lib
export LIBRARY_PATH

LD_RUN_PATH=$HOME/local/bin:/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/bin:/usr/sbin:/sbin
export LD_RUN_PATH

# 在 mac 容易出问题，尤其在 jpeg/png 的多版本情况下
DYLD_LIBRARY_PATH=$HOME/local/lib:/usr/local/mysql/lib
export DYLD_LIBRARY_PATH

DYLD_FALLBACK_LIBRARY_PATH=/opt/local/lib:/usr/lib
export DYLD_FALLBACK_LIBRARY_PATH
# end for gcc }

#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u\[\033[00m\]\[\033[31;40m\]@\[\033[00m\]\[\033[36;40m\]\h\[\033[00m\]:\[\033[35;40m\]\w\[\033[00m\]\$ '
PS1="\[\033[01;32m\]\[\033[00m\]\[\033[31;40m\]@\[\033[00m\]\[\033[36;40m\]\h\[\033[00m\]:\[\033[35;40m\]\w\[\033[00m\]$yellow\$git_branch$white\$ $normal"

# 加入 git  自动补齐
source /Users/hy0kl/profile/local/git-completion.bash 
