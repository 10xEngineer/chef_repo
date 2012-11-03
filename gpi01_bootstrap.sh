#!/bin/sh

set -e -x

TARGET=gpi01
NODE=${TARGET}

. shared/bootstrap.sh

ssh -A ubuntu@${TARGET} <<'ENDSSH2'
cd /var/chef
sudo tar xvfz /tmp/chef_repo.tar.gz
sudo chef-solo -c /var/chef/nodes/gpi01/solo.rb -j /var/chef/nodes/gpi01/node.json
ENDSSH2

echo "Happy? Happy!"

