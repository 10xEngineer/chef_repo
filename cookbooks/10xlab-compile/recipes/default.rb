# cookbook 10xlab-compile

# TODO create user
user "compile" do
  comment "10xLabs compile service"
  uid 1667
  gid "users"
  home "/home/compile"
  shell "/bin/sh"
  password "$1$n1NZCRfR$9nERbvjfw0EXRe4PrmBAi0"
  supports :manage_home => true
end

directory "/home/compile/.ssh" do
  action :create
  owner "compile"
  group "users"
  mode 0700
end

cookbook_file "/home/compile/.ssh/authorized_keys" do
  source "authorized_keys"
  owner "compile"
  group "users"
  mode 0600
end

# ssh wrapper for deploying from github
# TODO move to separate cookbook/recipe (shared with 10xeng-mc)
cookbook_file "/home/compile/wrap-ssh4git.sh" do
  source "wrap-ssh4git.sh"
  owner "compile"
  mode 0755
end

# checkout latest microcloud code
# TODO currently using key via ssh agent forward (same as withing 10xeng-mc::default)
git "/home/compile/deploy" do
  repository "git@github.com:10xEngineer/microcloud.10xEngineer.git"
  reference "master"
  action :sync
  ssh_wrapper "/home/microcloud/wrap-ssh4git.sh"
end
