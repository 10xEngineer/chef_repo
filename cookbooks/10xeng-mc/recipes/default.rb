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
  mode 0755
end

# tenxeng:4haMWE4RoQGr
#cookbook_file "/home/microcloud/htpasswd" do
#  source "htpasswd"
#  owner "root"
#  mode 0644
#
#  notifies :restart, "service[nginx]"
#end

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

# run bundler
script "install gems" do
  interpreter "bash"
  user "root"
  cwd "/home/microcloud/deploy/service"
  code <<-EOH
  bundle install
  EOH
end

# main services
runit_service "microcloud"
runit_service "taskeng"

template "/home/microcloud/deploy/service/Procfile" do
  source "Procfile.erb"
  user "root"
  group "root"
  mode "0644"
end

# FIXME services to be configurable via attributes
%w{broker ec2 dummy lxc loop git_adm}.each do |serv_name|
  runit_service serv_name

  service serv_name do
    supports :status => true, :restart => true, :reload => true
    action [ :start ]
  end
end

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

# FIXME need to provide 10xeng.yaml config
# FIXME buckets for binary distributions
# FIXME provisiong AMIs for 10xeng AWS account
# FIXME toolchain binary distribution to 10xeng AWS account
# FIXME get DNS endpoint