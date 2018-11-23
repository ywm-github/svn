# !/bin/bash
# by ywm
# svn install
# 2018-11-22

clear
#svn版本号,安装目录
dir='/usr/local/'
softs='apr-1.6.5 apr-util-1.6.1 zlib-1.2.11 sqlite3 pcre-8.00  subversion-1.10.3'
cur_dir=$(pwd)
echo '-----------------安装subversion-1.10.3----------------'
echo '安装expect'
rpm -Uh  sources/expat-2.1.0-10.el7_3.x86_64.rpm >/dev/null 2>&1
rpm -Uh  sources/expat-devel-2.1.0-10.el7_3.x86_64.rpm >/dev/null 2>&1
echo "expect 安装成功"
set -e
cd $cur_dir/sources

for soft in $softs;do
echo "开始解压：$soft"
tar -xf $soft.tar.gz >/dev/null 2>&1
echo "开始编译安装：$soft"
cd $soft

if [ `echo $soft |grep 'sub'` ];then
./configure --prefix=$dir/$soft  --with-apr=$dir/apr-1.6.5  --with-apr-util=$dir/apr-util-1.6.1  --with-lz4=internal --with-utf8proc=internal  >/dev/null 2>&1 

elif [ `echo $soft|grep 'util'` ] ;then
./configure --prefix=$dir/$soft  --with-apr=$dir/apr-1.6.5  >/dev/null 2>&1
elif [ `echo $soft |grep 'sqlite'` ];then
./configure >/dev/null 2>&1
else 
./configure --prefix=$dir/$soft >/dev/null 2>&1

fi
make >/dev/null 2>&1
make install >/dev/null 2>&1
echo $soft 安装成功
cd ..

done
echo "svn 安装目录 /usr/local/subversion-1.10.3"
echo "---------------subversion-1.10.3 安装完毕----------------"
