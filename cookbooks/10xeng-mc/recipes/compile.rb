# 10xeng-mc::compile

include_recipe "nginx"
include_recipe "10xeng-mc::default"


# add .ssh/config with StrictHostKeyChecking
directory "/home/microcloud/.ssh" do
  user "microcloud"
  group "users"

  mode "0755"
end

template "/home/microcloud/.ssh/config" do
  source "ssh_config.erb"

  user "microcloud"
  mode "0644"
end
