# 10xeng-mc::eu-1-aws

include_recipe "nginx"

cookbook_file "/etc/ssl/certs/eu-1-aws.crt" do
	source "eu-1-aws.crt"
	owner "root"
	group "root"

	mode 0644

	action :create
end

cookbook_file "/etc/ssl/private/eu-1-aws.key" do
	source "eu-1-aws.key"
	owner "root"
	group "root"

	mode 0600

	action :create
end

template "/etc/nginx/sites-available/api_eu-1-aws.conf" do
  owner "root"
  group "root"

  mode 0644

  source "api_eu-1-aws.conf.erb"
end

nginx_site "api_eu-1-aws.conf" do
  enable true

  notifies :restart, "service[nginx]"
end