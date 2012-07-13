# cookbook 10xeng-mc

include_recipe "nginx"

# ruby dependencies
%w{build-essential libxml2-dev libxslt-dev}.each do |p|
  package p do
    action :upgrade
  end
end

# node dependencies
%w{pkg-config uuid uuid-dev}.each do |p|
  package p do
    action :upgrade
  end
end

# microcloud user
user "microcloud" do
  comment "Microcloud user"
  uid 1666
  gid "users"
  home "/home/microcloud"
  shell "/bin/sh"
  password "$1$n1NZCRfR$9nERbvjfw0EXRe4PrmBAi0"
  supports :manage_home => true
end

# ssh wrapper for deploying from github
# TODO move to separate cookbook/recipe
cookbook_file "/home/microcloud/wrap-ssh4git.sh" do
  source "wrap-ssh4git.sh"
  owner "ubuntu"
  mode 0700
end

# checkout latest microcloud code
git "/home/microcloud/deploy" do
  repository "git@github.com:10xEngineer/microcloud.10xEngineer.git"
  reference "master"
  action :sync
  ssh_wrapper "/home/microcloud/wrap-ssh4git.sh"
end

# run npm
script "install npm packages" do
  interpreter "bash"
  user "root"
  cwd "/home/microcloud/deploy"
  code <<-EOH
  npm install
  EOH
end

runit_service "microcloud"

service "microcloud" do
  supports :status => true, :restart => true, :reload => true
  action [ :start ]
end

template "/etc/nginx/sites-available/microcloud.conf" do
  source "microcloud.conf.erb"
end

nginx_site "microcloud.conf" do
  enable true
end