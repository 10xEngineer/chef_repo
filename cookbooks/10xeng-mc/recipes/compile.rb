# 10xeng-mc::compile

script "install npm packages" do
  interpreter "bash"
  user "root"
  cwd "/home/microcloud/deploy/compile_serv"
  code <<-EOH
  npm install
  EOH
end

runit_service "compile_serv"

service "compile_serv" do
  supports :status => true, :restart => true, :reload => true
  action [ :start ]
end

template "/etc/nginx/sites-available/compile.conf" do
  source "compile.conf.erb"
end

nginx_site "compile.conf" do
  enable true
end