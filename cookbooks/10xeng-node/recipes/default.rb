# cookbook mc-node
# recipe default

directory "/var/lib/10eng/" do
  owner "mchammer"
  group "users"

  recursive true
  mode "0775"

  action :create
end

# TODO where to source gem from?
cookbook_file "/tmp/10xengineer-node.gem" do
  source "10xengineer-node-#{node["10xeng-node"]["toolchain"]["version"]}.gem"
  mode "0644"
end

gem_package "/tmp/10xengineer-node.gem" do
  action :install
end

service "lxc-net" do
  supports :status => true, :restart => true
  action :start
end

# adds dnsmasq dhcp-script
cookbook_file "/etc/init/lxc-net.conf" do
  source "lxc-net.conf"
  mode "0644"

  notifies :restart, "service[lxc-net]"
end

template "/etc/10xlabs-hostnode.json" do
  source "10xlabs-hostnode.json.erb"
  mode "0644"
end

script "dpkg_into_chroot" do
  interpreter "bash"
  user "root"
  cwd "/var/cache/lxc"
  code <<-EOH
  arch=`/usr/bin/dpkg --print-architecture`
  dpkg --root=/var/cache/lxc/precise/rootfs-${arch} -i /var/cache/lxc/10xlab-bootstrap.deb
  EOH

  action :nothing
end

cookbook_file "/var/cache/lxc/10xlab-bootstrap.deb" do
  source "10xlab-bootstrap_#{node["10xeng-lxc"]["bootstrap"]["version"]}.deb"
  mode "0644"

  notifies :run, "script[dpkg_into_chroot]", :immediately
end

# --- node_serv ---
cookbook_file "/tmp/10xlabs-node-serv_#{node["10xeng-lxc"]["node_serv"]["version"]}.deb" do
  source "10xlabs-node-serv_#{node["10xeng-lxc"]["node_serv"]["version"]}.deb"
  mode "0644"
end

package "10xlabs-node-serv" do
  source "/tmp/10xlabs-node-serv_#{node["10xeng-lxc"]["node_serv"]["version"]}.deb"
  provider Chef::Provider::Package::Dpkg  
  
  action :install
end

runit_service "node_serv"

#
# install lxc templates (currently only lxc-ubuntu - based on default, only adding 
# configurable packages
#
# TODO better template distribution mechanism / support other platforms
# FIXME temporarily removed (due to a number of issues with lxc provisioning/cgroups)
#
#template "/usr/lib/lxc/templates/lxc-ubuntu" do
#  source "lxc-ubuntu.erb"
#  mode "0755"
#end

# FIXME cover notification as part of tests (important)
ruby_block "notify_mc" do 
  block do
    Chef::Log.info "Microcloud endpoint url=#{node['microcloud']['endpoint']}"
    if node['microcloud']['endpoint']
      # FIXME move to LWPR?
      require 'microcloud'

      data = {
        :hostname => node.has_key?("ec2") ? node["ec2"]["public_hostname"] : node["hostname"]
      }

      microcloud = TenxLabs::Microcloud.new(node['microcloud']['endpoint'])
      microcloud.submit_event('node', node['10xeng-node']['id'], 'confirm', data)
    end
  end
end