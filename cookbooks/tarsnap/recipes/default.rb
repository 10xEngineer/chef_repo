# tarsnap::default

%w{e2fslibs-dev libssl-dev make zlib1g-dev}.each do |pkg|
	package pkg do
		action :install
	end
end

directory "/root/bin" do
	owner "root"
	group "root"

	mode 0755

	action :create
end

directory "/root/dump" do
	owner "root"
	group "root"

	mode 0755

	action :create
end

directory "/root/.tarsnap/cache" do
	owner "root"
	group "root"

	mode 0755

	recursive true

	action :create
end

cookbook_file "/root/.tarsnap/10xeng_gpi01-write" do
	owner "root"
	group "root"

	mode 0600

	action :create
end

cookbook_file "/root/bin/mongo_backup.sh" do
	owner "root"
	group "root"

	mode 0755

	action :create
end

cron "mongo_backup" do
  hour "*/4"
  minute "0"
  command "/root/bin/mongo_backup.sh"
end