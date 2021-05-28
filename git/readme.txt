git命令使用

[git remote]
git remote add origin ssh://git@xxx.com/xxx.git


[git push]
把本地仓库提交到远程仓库的master分支中
git push ssh://git@xxx.com/xxx.git master
git push origin master
git push -f(git push -u master origin -f)强制提交
-u 建立本地分支与远程分支的关联，之后git push等操作时，会默认把另一个作为交互的分支
git branch --set-upstream-to origin/dev master
git push origin test:master       提交本地test分支作为远程的master分支
git push origin test:test         提交本地test分支作为远程的test分支
git push origin :test             远程的test将被删除，但是本地还会保存的


[git fetch]
git fetch --prune  #这样就可在本地删除在远程不存在的branch
git fetch --progress --prune (-pP)


[git tag]
git tag
git tag --delete  (or -d if your git version is older than 1.8.0):
git push --delete origin tagname
git tag --delete tagname

git tag -l | xargs git tag -d    #delete local tag(s)
git fetch origin --tags   #remote tags are fetched


[git branch]
git branch 列出本地git库中的所有分支。当前分支名前有*
git branch –r 列出服务器git库的所有分支。
git branch –d branch-name 删除本地分支。

git checkout [-f] branch-name [强制]切换到分支
git checkout –b 新分支名 创建一个新分支，并切换到该分支上
git checkout --orphan branch-name 创建一个独立的新分支


[git log]
git log 查看近期 commit 的信息
git log -1 显示一个commit 可以是任意正数
Git log --stat –summary 显示每次版本的详细变化
git log --pretty=format:"%h - %an, %ar : %cn :%ce" 模版输出
%h hash
%an 作者名字,
%ae 作者邮箱
%ar 作者改动时间
%cn 提交者名字
%ce 提交者邮箱


git rm f1 删除文件f1，包含本地文件和index中的此文件记录
git rm –r * 删除当前目录下的所有文件和子目录
git rm --ached f1 删除文件f1，不会删除本地文件，只删除index中的文件记录

git 版本回退
git reset --hard SHA  commit 后面的一串字符就是 SHA 字符。
git reset --soft SHA

git cherry-pick -x -n a01a15a


[git commit]
git show SHA // 提交细节

git checkout HEAD -- package-lock.json // 放弃某些文件的更改
git restore ./ // 放弃某些文件的更改
git restore --staged ./ // 放弃某些文件的git add

git commit –am “message”

git commit –-amend –m “message” --author="YourName <you@example.com>" 在一个commit id上不断修改提交的内容
git commit --amend --reset-author 在一个commit id上修改提交者和作者


[git stash]
git stash
git stash save <message>
git stash create <message>
git stash 总是新增到 stash list 第0位

git stash list
git stash show 0 -p
    -p 显示个文件内容更改
git stash drop 0
git stash apply 0
git stash pop


[git rebase] 修改历史提交信息
git rebase -i <commit-id>
git rebase -i HEAD~2 倒数第2个

reword 只修改commit的message
edit 可以进行一系列git commit –-amend操作
squash 合并到上一个 commit 中，且将该 commit 的注释添加到上一个 commit 注释中
fixup 同 squash 放弃当前 commit 的注释

例：git commit --amend --author="YourName <you@example.com>" --no-edit

git rebase --continue
git rebase --edit-todo
注：git rebase -i --root修改所有commit，包括第一个


[git merge]
git merge --no-ff v0.2.0 //

--ff
the merge resolves as a fast-forward, only update the branch pointer, without creating a merge commit. This is the default behavior.




git config
git config [--global] -l
git config [--global] core.quotepath false // 解决git status 中文乱码的问题
git config [--global] core.ignorecase false





[.gitignore 配置]
1、配置语法：
	以斜杠“#”开头表示注释；
	以斜杠“/”开头表示根目录；
	以星号“*”通配多个字符；
	以星号“**”通配中间目录；
	以问号“?”通配单个字符
	以方括号“[]”包含单个字符的匹配列表；
	以叹号“!”表示不忽略(跟踪)匹配到的文件或目录；
此外，git 对于 .ignore 配置文件是按行从上到下进行规则匹配的，意味着如果前面的规则匹配的范围更大，则后面的规则将不会生效；

2、示例：
（1）规则：fd1/*   fd1/  fd1
　　　　  说明：忽略目录 fd1 下的全部内容；注意，不管是根目录下的 /fd1/ 目录，还是某个子目录 /child/fd1/ 目录，都会被忽略；
（2）规则：/fd1/*
　　　　  说明：忽略根目录下的 /fd1/ 目录的全部内容；
（3）规则：
/*
!.gitignore
!/fw/bin/
!/fw/sf/
说明：忽略全部内容，但是不忽略 .gitignore 文件、根目录下的 /fw/bin/ 和 /fw/sf/ 目录；
（4）规则：**/fw/bin
　　　　  说明：忽略任意目录下的fw目录下的bin，fw/bin不起作用




github
fork：从别人的代码库中复制一份到你自己的代码库，与普通的复制不同，fork包含了原有库中的所有提交记录，fork后这个代码库是完全独立的，属于你自己，你可以在自己的库中做任何修改，当然也可以通过Pull Request向原来的库提交合并请求。
Watch：关注。关注后，代码库中有新的commit你都会收到通知；
Star：与watch不同，star相当于收藏。你可以方便地找到你star过的库，但是不会收到关于那个库的任何通知。



CRLF，LF
CRLF, LF 是用来表示文本换行的方式。CR(Carriage Return) 代表回车，对应字符 '\r'；LF(Line Feed) 代表换行，对应字符 '\n'。
由于历史原因，不同的操作系统文本使用的换行符各不相同。主流的操作系统一般使用CRLF或者LF作为其文本的换行符。
其中，Windows 系统使用的是 CRLF, Unix系统(包括Linux, MacOS近些年的版本) 使用的是LF。

git config [--global] core.autocrlf true|false|input
开发和生产都只在Windows系统上，把它设置成false，取消此功能，把回车符记录在库中。

在Windows系统上，把它设置成true，这样提交时自动地把行结束符CRLF转换成LF，而在签出代码时把LF转换成CRLF。
在Linux或Mac系统上，把它设置成input，这样提交时自动地把行结束符CRLF转换成LF，而在签出代码时不需要转换。


CRLF 与 LF 混合的文本文件不受此配置控制。







[ssh登录]
密钥登录：ssh -i 密钥位置 SvcCOPSSH@localhost
密码登录：ssh SvcCOPSSH@localhost
mkdir testgit
cd testgit
git init
touch a b d f kf f
git add .  添加当前目录下的所有文件和子目录
git config --global user.email "you@example.com"
git config --global user.name "Your Name"
git commit -am "1"  －a可以将那些没有通过git add标识的变化一并强行提交
git status
//设置push
git config receive.denyCurrentBranch ignore
或者
echo "[receive]  denyCurrentBranch = ignore" >>.git/config

git reset--hard



cd ../../home/SvcCOPSSH
cd .ssh
cat authorized_keys

echo "StrictModes no  ">>sshd_config