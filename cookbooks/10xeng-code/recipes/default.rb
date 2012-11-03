# 10xeng-code::default

# dependencies
%w{pkg-config uuid uuid-dev}.each do |p|
  package p do
    action :upgrade
  end
end

group "labsys" do
	gid 1666
end

# microcloud user
user "labsys" do
  comment "Labs System user"
  uid 1666
  gid "labsys"
  home "/home/labsys"
  shell "/bin/bash"
  password "$1$zq8LgADX$kIKNNFfUPCgF.JnJd.cl21"
  supports :manage_home => true
end

directory "/home/labsys/bin/" do
	owner "labsys"
	group "labsys"

	mode 0755

	action :create
end

directory "/home/labsys/.ssh/" do
	owner "labsys"
	group "labsys"

	mode 0755

	action :create
end

cookbook_file "/home/labsys/.ssh/labs_deploy" do
	source "labs_deploy"

	owner "labsys"
	group "labsys"

	mode 0600

	action :create
end

cookbook_file "/home/labsys/bin/wrap-ssh4git.sh" do
	source "wrap-ssh4git.sh"

	owner "labsys"
	group "labsys"

	mode 0755
end

git "/home/labsys/base" do
  repository "git@github.com:10xEngineer/microcloud.10xEngineer.git"

  reference "master"
  user "labsys"
  group "labsys"

  action :sync

  ssh_wrapper "/home/labsys/bin/wrap-ssh4git.sh"
end

# run npm
script "install npm packages" do
  interpreter "bash"
  user "labsys"
  cwd "/home/labsys/base"
  code <<-EOH
  export HOME=/home/labsys
  npm install
  EOH
end

