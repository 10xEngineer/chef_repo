# 10xeng-hosts::default

hosts = []
_hosts = data_bag('hosts')
_hosts.each do |host|
	_host = data_bag_item('hosts', host)

	hosts << _host.raw_data
end


template "/etc/hosts" do
	source "hosts.erb"

	mode 0644
	owner "root"
	group "root"

	variables({
		:hosts => hosts
	})

end