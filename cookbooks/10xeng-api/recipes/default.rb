# 10xeng-api::default

runit_service "api"

service "api" do
  supports :status => true, :restart => true, :reload => true
  action [ :start ]
end

template "/etc/nginx/sites-available/labs_api.conf" do
  owner "root"
  group "root"

  mode 0644

  source "labs_api.conf.erb"
end

nginx_site "labs_api.conf" do
  enable true
end
