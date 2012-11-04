# 10xeng-mc::eu-1-aws

include_recipe "nginx"

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