#!/bin/sh

set -e -x

cookbook_dir=`pwd`

cd /tmp
rm -Rf GateOne

git clone git://github.com/10xEngineer/GateOne.git
cd GateOne
commit=`git log -1 --format="%h"`
archive="gateone_${commit}.tar.gz"

cd GateOne
tar -cz -f /tmp/${archive} --exclude .git .

cd $cookbook_dir
mv /tmp/${archive} ./files/default/${archive}

cat attributes/default.rb | sed "s/\= \"\([a-z0-9]\{7\}\)\"/\= \"${commit}\"/" >attributes/default.rb.new
mv attributes/default.rb.new attributes/default.rb

