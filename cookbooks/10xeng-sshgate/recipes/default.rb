# 10xeng-sshgate::default

group "sshgate" do
	gid "1667"
end

directory "/home/sshgate" do
	owner "root"
	group "root"

	mode 0755

	action :create
end

_proxies = data_bag("ssh_proxies")
_proxies.each do |_proxy|
	proxy = data_bag_item('ssh_proxies', _proxy)

	user proxy["id"] do
	  comment "Labs SSH Proxy user"
	  uid proxy["uid"]
	  gid "sshgate"
	  home "/home/sshgate"
	  shell "/bin/false"
	  password "$1$zq8LgADX$kIKNNFfUPCgF.JnJd.cl21"
	end
end
