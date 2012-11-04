# 10xeng-api::default

runit_service "api"

service "api" do
  supports :status => true, :restart => true, :reload => true
  action [ :start ]
end

nginx_site "labs_api.conf" do
  enable true
end
