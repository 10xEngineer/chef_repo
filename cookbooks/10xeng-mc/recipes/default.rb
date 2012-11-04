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

# service gems
script "install gems" do
  interpreter "bash"
  user "root"
  cwd "/home/labsys/base/service"
  code <<-EOH
  bundle install
  EOH
end

directory "/etc/labs" do
  user "root"
  group "root"
  mode "0755"
end

cookbook_file "/home/labsys/.ssh/id_rsa" do
  source "mchammer-dev"
  user "labsys"
  group "labsys"
  mode "0600"
end

template "/home/labsys/base/service/Procfile" do
  source "Procfile.erb"
  user "root"
  group "root"
  mode "0644"
end

# dummy lxc key
%w{broker dummy lxc key}.each do |serv_name|
  runit_service serv_name

  service serv_name do
    supports :status => true, :restart => true, :reload => true
    action [ :start ]
  end
end

runit_service "microcloud"
service "microcloud" do
  supports :status => true, :restart => true, :reload => true
  action [ :start ]
end

