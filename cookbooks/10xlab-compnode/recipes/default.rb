# 10xlab-compnode::default

group node["10xlab"]["compnode"]["sandbox_group"] do
	gid node["10xlab"]["compnode"]["sandbox_gid"]
end

directory node["10xlab"]["compnode"]["home_location"] do
	owner "root"
	group node["10xlab"]["compnode"]["sandbox_group"]
	mode 0755

	action :create
end

template "/etc/sandbox_adduser.conf" do
	source "sandbox_adduser.conf.erb"
	owner "root"
	group "root"

	mode "0600"
end
