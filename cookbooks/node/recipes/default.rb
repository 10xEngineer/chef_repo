# cookbook: node
# recipe: default
# 
# instructions based on 
# https://github.com/joyent/node/wiki/Installing-Node.js-via-package-manager

package "python-software-properties" do
  action :install
end

apt_repository "node.js" do
  uri node["nodejs"]["repository"]
  distribution node['lsb']['codename']
  components ["main"]

  keyserver node['nodejs']['keyserver']
  key node['nodejs']['key']

  action :add

  notifies :run, "execute[apt-get update]", :immediately
end

package "nodejs" do
  action :upgrade
end

package "npm" do
  action :upgrade
end
