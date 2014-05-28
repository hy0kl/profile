# 删除在本地有但在远程库中已经不存在的分支

[FROM](http://blog.csdn.net/xhl_will/article/details/8450193)

查看远程库的一些信息，及与本地分支的信息。有时候可能遇到如下情况:

```
$ git remote show origin

* remote origin
  Fetch URL: ... .git
  Push  URL: ... .git
  HEAD branch: master
  Remote branches:
    dev                     tracked
    jqmobi                  tracked
    master                  tracked
    refs/remotes/origin/3.1 stale (use 'git remote prune' to remove)
    refs/remotes/origin/tc  stale (use 'git remote prune' to remove)
    refs/remotes/origin/xhl stale (use 'git remote prune' to remove)
  Local branches configured for 'git pull':
    dev    merges with remote dev
    master merges with remote master
  Local refs configured for 'git push':
    dev    pushes to dev    (up to date)
    jqmobi pushes to jqmobi (up to date)
    master pushes to master (up to date)
```

其中3.1, tc, xhl三个分支在远程库已经不存在了（你之前从远程库拉取过，可能之后被其他人删除了，你用 git branch -a 也是不能看出它们是否已被删除的），这时候我们可以删除本地库中这些相比较远程库中已经不存在的分支：

```
$ git remote prune origin
warning: more than one branch.master.remote
Pruning origin
URL: ... .git
 * [pruned] origin/3.1
 * [pruned] origin/tc
 * [pruned] origin/xhl
```

再 git branch -a 查看.搞定

# 如何只克隆 git 仓库中的一个分支？

```
$ git clone -b <branch> <remote_repo>
```
