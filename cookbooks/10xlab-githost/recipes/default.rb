# recipe[10xlab-githost::default]

# TODO one time setup
# TODO import admin user / gitolite-admin/config/gitolite.conf

chef_gem "ruby-shadow" do
  action :install
end

group "git" do
  gid 1066
end

user "git" do
  comment "GIT user"
  uid 1066
  gid 1066

  home "/home/git"
  shell "/bin/bash"

  password "$1$W12MjPvD$nbwLXSX1Tbv4xEWZAKTeI/"

  supports :manage_home => false
end

# setup home directory + ~/bin for gitolite
directory "/home/git" do
  owner "git"
  group "git"
  mode "0755"

  recursive true

  action :create
end

directory "/home/git/bin" do
  owner "git"
  group "git"
  mode "0755"

  recursive true

  action :create
end


# default admin public key
cookbook_file "/home/git/tenxgit.pub" do
  source "tenxgit.pub"
  mode "0644"
end

# sync gitolite
git "/home/git/gitolite" do
  repository "git://github.com/sitaramc/gitolite"
  reference "master"

  action :sync
end

script "install gitolite" do
  interpreter "bash"
  user "git"
  cwd "/home/git"
  code <<-EOH
  HOME=/home/git
  ./gitolite/install -to $HOME/bin
  /home/git/bin/gitolite setup -pk tenxgit.pub
  EOH
end