#!/bin/sh

: ${TARGET?"Set target instance for bootstrap as 'export TARGET=hostname' before running script."}

# bootstrap
# ec2-54-247-14-231.eu-west-1.compute.amazonaws.com
ssh -A ubuntu@${TARGET} <<'ENDSSH'
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y install ruby1.9.3 build-essential vim linux-headers-$(uname -r)

sudo /usr/bin/gem install chef --no-ri --no-rdoc
sudo /usr/bin/gem install ruby-shadow --no-ri --no-rdoc

sudo rm -Rf /var/chef
sudo mkdir -p /var/chef
ENDSSH

# distribute
tar -cz -f /tmp/chef_repo.tar.gz .
scp /tmp/chef_repo.tar.gz ubuntu@${TARGET}:/tmp/
# TODO replace 
scp ../service/security/mc_deploy ubuntu@${TARGET}:/tmp/
rm /tmp/chef_repo.tar.gz

ssh -A ubuntu@${TARGET} <<'ENDSSH2'
cd /var/chef
sudo tar xvfz /tmp/chef_repo.tar.gz
sudo chef-solo -c /var/chef/nodes/microcloud/solo.rb -j /var/chef/nodes/microcloud/node.json
ENDSSH2

echo "Happy? Happy!"