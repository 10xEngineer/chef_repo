# virtualbox::default

def build_packages
	uname=`uname -r`

	packages = []
	packages << "linux-headers-#{uname.strip}"
	packages << %w{build-essential virtualbox-4.1 dkms}
	packages.flatten!

	packages
end

packages = build_packages

apt_repository "oracle_virtualbox" do 
	uri "http://download.virtualbox.org/virtualbox/debian"
	distribution node['lsb']['codename']
	components ["contrib"]
	key "http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc"

	action :add
end

packages.each do |pkg|
	package pkg do
		action :install
	end
end