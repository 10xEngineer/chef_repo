#!/bin/sh

set -e -x

: ${TARGET?"Set target instance for bootstrap as 'export TARGET=hostname' before running script."}
export NODE=hostnode

. shared/bootstrap.sh

ssh -A ubuntu@${TARGET} <<'ENDSSH2'
cd /var/chef
sudo tar xvfz /tmp/chef_repo.tar.gz
sudo chef-solo -c /var/chef/nodes/hostnode/solo.rb -j /var/chef/nodes/hostnode/node.json
ENDSSH2

echo "Happy? Happy!"

