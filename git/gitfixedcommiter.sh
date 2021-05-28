#!/bin/sh

#: << !
git filter-branch -f --commit-filter '

if [ "$GIT_COMMITTER_EMAIL" = "liuxy@xxx.com.cn" ]
then
    GIT_COMMITTER_NAME="liuxy"
    GIT_COMMITTER_EMAIL="938651469@qq.com"
fi
if [ "$GIT_AUTHOR_EMAIL" = "liuxy@xxx.com.cn" ]
then
    GIT_AUTHOR_NAME="liuxy"
    GIT_AUTHOR_EMAIL="938651469@qq.com"
    git commit-tree "$@";
else
    git commit-tree "$@";
fi

' HEAD
#!

: << !
git filter-branch --env-filter '

if [ "$GIT_COMMITTER_EMAIL" = "liuxy@xxx.com.cn" ]
then
    GIT_COMMITTER_NAME="liuxy"
    GIT_COMMITTER_EMAIL="938651469@qq.com"
fi
if [ "$GIT_AUTHOR_EMAIL" = "liuxy@xxx.com.cn" ]
then
    GIT_AUTHOR_NAME="liuxy"
    GIT_AUTHOR_EMAIL="938651469@qq.com"
fi
export GIT_COMMITTER_NAME
export GIT_COMMITTER_EMAIL
export GIT_AUTHOR_NAME
export GIT_AUTHOR_EMAIL

'
!