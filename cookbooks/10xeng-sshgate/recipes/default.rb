# 10xeng-sshgate::default

# -- install patched openssh
package "python-software-properties" do
  action :install
end

apt_repository "ssh-akc" do
  uri node["ssh-akc"]["repository"]
  distribution node['lsb']['codename']
  components ["main"]

  key node['ssh-akc']['key']

  action :add

  notifies :run, "execute[apt-get update]", :immediately
end

package "openssh-akc-server" do
	action :install

	notifies :restart, "service[ssh]"
end

cookbook_file "/etc/ssh/authorized_keys.sh" do
	source "authorized_keys.sh"

	user "root"
	group "sshgate"

	mode 0755

	action :create
end

cookbook_file "/etc/ssh/ssh_connect.sh" do
	source "ssh_connect.sh"

	user "root"
	group "sshgate"

	mode 0755

	action :create
end

cookbook_file "/etc/ssh/sshd_config" do
	source "sshd_config"

	user "root"
	group "root"

	mode 0644

	action :create
end

service "ssh" do
	supports :restart => true, :reload => true, :status => true

	action :start
end

# -- users

group "sshgate" do
	gid "1667"
end

directory "/home/sshgate/.ssh" do
	owner "root"
	group "root"

	mode 0755

	recursive true	

	action :create
end

_proxies = data_bag("ssh_proxies")
_proxies.each do |_proxy|
	proxy = data_bag_item('ssh_proxies', _proxy)

	user proxy["id"] do
	  comment "Labs SSH Proxy user"
	  uid proxy["uid"]
	  gid "sshgate"
	  home "/home/#{proxy["id"]}"
	  shell "/bin/false"
	  password "$1$zq8LgADX$kIKNNFfUPCgF.JnJd.cl21"
	end

	directory "/home/#{proxy["id"]}/.ssh" do
		owner proxy["uid"]
		group "sshgate"

		mode 0755

		recursive true	

		action :create
	end

	cookbook_file "/home/#{proxy["id"]}/.ssh/id_rsa" do
		source "labproxy_key"
		
		owner proxy["uid"]
		group "sshgate"

		mode 0600

		action :create
	end
end

