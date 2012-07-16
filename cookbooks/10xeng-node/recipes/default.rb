# cookbook mc-node
# recipe default

admins = data_bag('admins')
admins.each do |uid|
  u = data_bag_item('admins', uid)

  home_dir = "/home/#{u["id"]}"

  user u["id"] do
    comment u["full_name"]
    uid u["uid"]
    gid u["groups"].first
    home home_dir
    shell u["shell"]

    supports :manage_home => false
  end

  directory home_dir do
    owner u["id"]
    group u["groups"].first
    mode "0775"

    action :create
  end

  directory "#{home_dir}/.ssh" do
    owner u["id"]
    group u["groups"].first
    mode "0700"

    action :create
  end

  template "/home/mchammer/.ssh/authorized_keys" do
    owner u["id"]
    group u["groups"].first
    mode "0600"

    variables :key => u["ssh_key"]

    action :create
  end
end

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

template "/etc/10xeng.yaml" do
  source "10xeng.yaml.erb"
  mode "0644"
end

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
if node['microcloud']['endpoint']
  http_request "confirm node" do
    action :post
    url "#{node['microcloud']['endpoint']}/nodes/#{node['10xeng-node']['id']}/notify"
    message :action => "confirm", :node => {
      :hostname => node.has_key?("ec2") ? node["ec2"]["public_hostname"] : node["hostname"]
    }
    # TODO authorization not yet supported
    if node['10xeng-node']['token']
      headers({"AUTHORIZATION" => "Basic #{Base64.encode64(node['10xeng-node']['token'])}"})
    end
  end
end
