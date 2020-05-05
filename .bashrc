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

# set encode
export LANG=C
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

### alias ###
# svn
alias svn-st='svn st | grep ^M'
alias svn-log='svn log -v --limit 5'

# professional alias
os=$(uname)
if [[ "Darwin" == $os ]] || [[ "FreeBSD" == $os ]]
then
    alias ls='ls -G'
    alias myip="ifconfig | grep 'inet ' | awk '{print \$2}'"
else
    alias ls='ls --color'
    alias myip="ifconfig | grep 'inet ' | awk '{split(\$2, ip_cntr, \":\"); print ip_cntr[2];}'"
fi
alias ll='ls -l'
alias la='ls -Aalth'
alias l='ls -CF'
alias lt='ls -lth'
alias tf='tail -f'
alias grep='grep --color=always'
alias tree='tree -C'
alias vih='sudo vim /etc/hosts'
alias cdiff='~/local/colordiff/colordiff.pl | less -R'
alias rscp='rsync -v -P -t -e ssh'
alias wget='wget -c'
alias sendmail='$HOME/local/sendEmail/sendEmail -f cli_mail@163.com -o message-content-type=auto -o message-charset=utf-8 -s smtp.163.com -xu cli_mail@163.com -xp Iwi11ct0'
alias mysql='mysql --auto-rehash'
alias ctagsp='ctags -R --langmap=PHP:.php.inc --php-types=c+f+d --exclude=.svn --exclude=svn --exclude=subversion --exclude=img  --exclude=swf --exclude=js --exclude=tpl --exclude=htdocs --exclude=html --exclude=sql --exclude=static --exclude=.git'
# tail -f 目录下所有文件
alias tailaf='find . -type f | xargs tail -f'
alias vi='vim'

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

# bash 升级到4.0后,安装 bash-completion,开启命令参数自动补全
if [ -f $HOME/local/bash/share/bash-completion/bash_completion ]; then
    . $HOME/local/bash/share/bash-completion/bash_completion
fi

# color man
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

PAGER='less -X -M'
export LESS=' -R '

export SVN_EDITOR=vim
export EDITOR=vim

export PATH=$HOME/local/bin:/usr/local/mysql/bin:$PATH

# 使用 HISTTIMEFORMAT 在历史中显示 TIMESTAMP
export HISTTIMEFORMAT='%F %T '


# 生成随机字符串
function _randpwd()
{
    str=`date +%s | shasum | base64 | head -c 16`
    echo $str
}
alias randpwd=_randpwd

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

# mac 不支持
function _straceall {
    strace $(pidof "${1}" | sed 's/\([0-9]*\)/-p \1/g')
}
alias straceall=_straceall

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

function _md2word()
{
    PANDOC_INSTALLED=$(pandoc --version >> /dev/null; echo $?)

    if [ "0" == ${PANDOC_INSTALLED} ]; then
        pandoc -o $2 -f markdown -t docx $1
    else
        echo "Pandoc is not installed. Unable to convert document."
    fi
}
alias md2word=_md2word

function _kgit()
{
    ps axu | grep git | grep -v grep | awk '{print $2}' | xargs kill -9
    exit 0
}
alias kgit=_kgit

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

# 日期转uninx时间戳毫秒
function _dt2um() {
    local args=$*
    if [[ "Darwin" == $os ]] || [[ "FreeBSD" == $os ]]
    then
        um=`date -j -f "%Y-%m-%d %H:%M:%S" "$args" "+%s"`
    else
        um=`date +%s -d "$args"`
    fi
    um=$((um * 1000))
    echo $um
}
alias dt2um=_dt2um

# uninx时间戳毫秒转日期
function _um2dt() {
    local um=$1
    um=$((um / 1000))
    if [[ "Darwin" == $os ]] || [[ "FreeBSD" == $os ]]
    then
        echo `date -r "$um" +"%Y-%m-%d %H:%M:%S"`
    else
        echo `date -d @"$um" +"%Y-%m-%d %H:%M:%S"`
    fi
}
alias um2dt=_um2dt

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

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
[[ $PS1 && -f /usr/local/share/bash-completion/bash_completion.sh ]] && \
    source /usr/local/share/bash-completion/bash_completion.sh

prompt='\$'
if [ "root" = "$USER" ]
then
    prompt='#'
fi

PS1="${white}[${green}\u${red}@${cyan}\h${normal}:${magenta}\w${white}]$yellow\$git_branch$white$prompt $normal"

# 加入 git  自动补齐
if [[ -f "$HOME/profile/local/git-completion.bash" ]]; then
    source $HOME/profile/local/git-completion.bash
fi

function _push_all() {
    branch=$(git remote -v | awk '{print $1}' | sort -u)
    for bc in $branch
    do
        echo "git push $bc master"
        git push $bc master
    done
}
alias push-all=_push_all

export ESHOST="http://127.0.0.1:9200"

function es_idx_info() {
    if [ $# -lt 1 ]; then
        echo "usage: es-idx-info index-name"
    else
        local idx=$1
        curl -H "Content-Type:application/json" -XGET $ESHOST/$idx/_settings?pretty
    fi
}
alias es-idx-info=es_idx_info

function es_idx_map() {
    if [ $# -lt 1 ]; then
        echo "usage: es-idx-map index-name"
    else
        local idx=$1
        curl -H "Content-Type:application/json" -XGET $ESHOST/$idx/_mapping?pretty
    fi
}
alias es-idx-map=es_idx_map

function es_idx_alias() {
    if [ $# -lt 1 ]; then
        echo "usage: es-idx-alias index-name"
    else
        local idx=$1
        curl -H "Content-Type:application/json" -XGET $ESHOST/$idx/_alias/*?pretty
    fi
}
alias es-idx-alias=es_idx_alias

function es_alias_idx() {
    if [ $# -lt 1 ]; then
        echo "usage: es-alias-idx alias-name"
    else
        local name=$1
        curl -H "Content-Type:application/json" -XGET $ESHOST/*/_alias/$name?pretty
    fi
}
alias es-alias-idx=es_alias_idx

function es_del_idx() {
    if [ $# -lt 1 ]; then
        echo "usage: es-del-idx index-name"
    else
        local idx=$1
        curl -XDELETE $ESHOST/$idx?pretty
    fi
}
alias es-del-idx=es_del_idx
alias es-idxs="curl $ESHOST/_cat/indices?v"
alias es-as="curl $ESHOST/_cat/aliases?v"
alias esc='curl -H "Content-Type:application/json"'

# 设置文件系统掩码,某些系统初始化后掩码有问题,统一设置为合理值
umask 0022
