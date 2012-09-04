# 10xeng-node::term_serv

# --- term_serv ---
package "g++" do
  action :install
end

cookbook_file "/tmp/10xlabs-term-serv_#{node["10xeng-lxc"]["term_serv"]["version"]}.deb" do
  source "10xlabs-term-serv_#{node["10xeng-lxc"]["term_serv"]["version"]}.deb"
  mode "0644"
end

package "10xlabs-term-serv" do
  source "/tmp/10xlabs-term-serv_#{node["10xeng-lxc"]["term_serv"]["version"]}.deb"
  provider Chef::Provider::Package::Dpkg  
  
  action :install
end

runit_service "term_serv"