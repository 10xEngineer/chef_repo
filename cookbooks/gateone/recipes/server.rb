# cookbook gateone

# install dependencies
node["gateone"]["dependencies"].each do |p|
  package p do
    action :upgrade
  end
end

# install distribution packages bundled with the cookbook
node["gateone"]["packages"].each do |p|
  cookbook_file "/tmp/#{p}" do
    source p
    mode "0644"
  end

  package p do
    provider Chef::Provider::Package::Dpkg
    source "/tmp/#{p}"
    action :install
  end
end

#
# install gateone from tag.gz distribution
# 
# TODO certificate distribution
# TODO api key distribution
# TODO configuration support
# TODO service 
cookbook_file "/tmp/gateone.tar.gz" do
  source "gateone_#{node["gateone"]["commit"]}.tar.gz"
end

template "/opt/gateone/server.conf" do
  # TODO configuration via attributes
  source "server.conf.erb"

  action :nothing
end

script "install gateone" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
  tar xvfz gateone.tar.gz -C /opt/gateone
  mkdir -p /opt/gateone/logs
  EOH

  action :nothing
  notifies :create, "template[/opt/gateone/server.conf]", :immediately
end

directory "/opt/gateone" do
  owner "root"
  group "root"
  mode "0755"

  action :create

  notifies :run, "script[install gateone]", :immediately
end
