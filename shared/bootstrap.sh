# . source from target script

set -x

# bootstrap
ssh -A ubuntu@${TARGET} <<'ENDSSH'
sudo apt-get clean
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y install ruby1.9.3 build-essential vim linux-headers-$(uname -r)

sudo /usr/bin/gem install chef --no-ri --no-rdoc
sudo /usr/bin/gem install ruby-shadow --no-ri --no-rdoc

sudo rm -Rf /var/chef
sudo mkdir -p /var/chef
ENDSSH

# distribute
gtar --exclude-vcs -cz -f /tmp/chef_repo.tar.gz .
scp /tmp/chef_repo.tar.gz ubuntu@${TARGET}:/tmp/
# TODO replace 
scp ../service/security/mc_deploy ubuntu@${TARGET}:/tmp/
rm /tmp/chef_repo.tar.gz

