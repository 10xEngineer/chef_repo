# redis::default
# 

package "python-software-properties" do
  action :install
end

execute "apt-get update" do
  command "apt-get update"
  
  action :nothing
end

apt_repository "redis-server" do
  uri node["redis"]["repository"]
  distribution node['lsb']['codename']
  components ["main"]

  keyserver node['redis']['keyserver']
  key node['redis']['key']

  action :add

  notifies :run, "execute[apt-get update]", :immediately
end

package "redis-server" do
  action :upgrade
end
