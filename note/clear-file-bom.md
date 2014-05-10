# linux下查找包含BOM头的文件和清除BOM头命令

[FROM](http://blog.sina.com.cn/s/blog_49f914ab0101eyjj.html)

```
查找包含BOM头的文件，命令如下：

grep -r -I -l $'^\xEF\xBB\xBF' ./

这条命令会查找当前目录及子目录下所有包含BOM头的文件，并把文件名在屏幕上输出。

但是，删除BOM头，网上找到的命令大多不能用，比较常见的命令是：

grep -r -I -l $'^\xEF\xBB\xBF' /path | xargs sed -i 's/^\xEF\xBB\xBF//;q'
但这条命令会把除了首行之外所有的行删除，所以毫无意义。

经测试如下命令是可行的：

 find . -type f   -exec  sed -i 's/\xEF\xBB\xBF//' {} \;

这个命令会把当前目录及所有子目录下的BOM头删除掉。
```
