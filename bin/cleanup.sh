path=`pwd`
[ $# -gt 0 ] && path=$1

find $path -name "\.DS_Store" -print0 | xargs -0 rm
find $path -name "\._*" -print0 | xargs -0 rm
