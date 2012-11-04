# 10xeng-manage::default

group "labsys" do
	gid 1666
end

user "manage_app" do
  comment "Labs Management App"
  uid 1667
  gid "labsys"
  home "/home/manage_app"
  shell "/bin/bash"
  password "$1$zq8LgADX$kIKNNFfUPCgF.JnJd.cl21"
  supports :manage_home => true
end

directory "/home/manage_app/bin/" do
	owner "manage_app"
	group "labsys"

	mode 0755

	action :create
end

directory "/home/manage_app/.ssh/" do
	owner "manage_app"
	group "labsys"

	mode 0755

	action :create
end

directory "/home/manage_app/tmp/" do
	owner "manage_app"
	group "labsys"

	mode 0755

	action :create
end

cookbook_file "/home/manage_app/.ssh/deploy_key" do
	source "deploy_key"

	owner "manage_app"
	group "labsys"

	mode 0600

	action :create
end

cookbook_file "/home/manage_app/bin/wrap-ssh4git.sh" do
	source "wrap-ssh4git.sh"

	owner "manage_app"
	group "labsys"

	mode 0755
end

git "/home/manage_app/webapp" do
  repository "git@github.com:10xEngineer/labs-manage.git"

  reference "master"
  user "manage_app"
  group "labsys"

  action :sync

  ssh_wrapper "/home/manage_app/bin/wrap-ssh4git.sh"

  notifies :restart, "service[manage_app]"
end

# bundle
script "install gem packages" do
  interpreter "bash"
  user "root"
  cwd "/home/manage_app/webapp"
  code <<-EOH
  bundle install
  EOH
end

script "precompile_assets" do
  interpreter "bash"
  user "root"
  cwd "/home/manage_app/webapp"
  code <<-EOH
  export HOME=/home/manage_app
  bundle exec rake assets:precompile
  EOH
end

runit_service "manage_app"

service "manage_app" do
  supports :status => true, :restart => true, :reload => true
  action [ :start ]
end

template "/etc/nginx/sites-available/manage_app.conf" do
  owner "root"
  group "root"

  mode 0644

  source "manage_app.conf.erb"
end

nginx_site "manage_app.conf" do
  enable true

  notifies :restart, "service[nginx]"
end
