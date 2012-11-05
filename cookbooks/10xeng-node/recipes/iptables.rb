# 10xeng-node::iptables

execute "load-iptables" do
  command "/etc/network/if-pre-up.d/iptables_load"

  user "root"
  
  action :nothing
end

cookbook_file "/etc/iptables.rules" do
	source "iptables.rules"

	mode 0644

	notifies :run, "execute[load-iptables]"
end

cookbook_file "/etc/network/if-pre-up.d/iptables_load" do
  source "iptables_load"
  mode 0755
end

