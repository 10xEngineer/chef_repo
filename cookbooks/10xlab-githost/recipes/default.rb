# recipe[10xlab-githost::default]

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

template "/home/git/.10xlab-repo" do
  source "10xlab-repo.erb"
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

  not_if do 
    File.exists?("/home/git/bin/gitolite")
  end
end

# sync gitolite
git "/home/git/gitolite" do
  repository "git://github.com/sitaramc/gitolite"
  reference "master"

  action :sync

  not_if do
    File.exists?("/home/git/bin/gitolite")
  end

  notifies :run, "script[install gitolite]"
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

  action :nothing
end

# initialize 10xlab metadata
git "/tmp/gitolite-admin" do
  repository "/home/git/repositories/gitolite-admin.git"
  action :sync
end

directory "/tmp/gitolite-admin/10xlabs" do
  owner "root"
  group "root"
  mode "0755"
end

cookbook_file "/tmp/gitolite-admin/10xlabs/metadata.json" do
  source "metadata.json"

  owner "root"
  group "root"
  mode "0644"

  action :create_if_missing
  notifies :run, "script[git_push]"
end

script "git_push" do
  interpreter "bash"
  user "root"
  cwd "/tmp/gitolite-admin"
  code <<-EOH
  git add 10xlabs/metadata.json
  git commit -m "Added 10xlabs metadata (10xlab-githost::default recipe)"
  git push -f
  EOH

  action :nothing
end

# TODO create 10xlab metadata
#      based on template / vs 
# TODO push it back