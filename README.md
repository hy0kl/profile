profile
=======

高级智能化工作环境

# 功能介绍

- 智能历史命令快速查找
- 各种命令行自动补全功能
- ctags全能支持
- 超强vim配置
  - nginx配置文件高亮
  - c/c++海量API高亮
  - awk脚本语法高亮
  - php/js/css/python/c系统函数/sql关键词自动补全
  - 记忆文件最后编辑位置
  - VI(M)DE,将vim当做IDE工具
- N多实用别名和参考脚本
- 彩色的man手册
- 自动识git分支
- 个性化登陆欢迎界面(需要安装`fortune`,`cowsay`)

# [Dependence]

* [ctags](http://ctags.sourceforge.net/)
* [tree](ftp://mama.indstate.edu/linux/tree/) ftp://mama.indstate.edu/linux/tree/

## Ubuntu

```
$ sudo apt-get install ctags tree vim
```

## BSD

```
# pkg install ctags tree vim
```

## CentOS

```
# yum install ctags tree vim
```

# 安装方法

```
$ cd ~
$ git clone https://github.com/hy0kl/profile.git    # https协议,防止抛ssh-key无权限
$ cd profile
$ ./install.sh
```

记得将`~/gitconfig`中的`name`,`email`改成自己的,否则提交日志中会出现默认的
