# 10xlab::default

gem_package "microcloud" do
  action :install
end

node["users"].each do |user|
  template "/tmp/#{user[:id]}-user_keys" do
    source "user_keys.erb"
    require 'microcloud'

    microcloud = TenxLabs::Microcloud.new(node["microcloud"]["endpoint"])
    key = microcloud.get(:key, user[:key])

    variables(:key => key["ssh_public_key"])
  end
end