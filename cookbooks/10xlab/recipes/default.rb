# 10xlab::default

gem_package "microcloud" do
  action :install
end

node["users"].each do |user|
  ruby_block "get_key" do
    block do
      require 'microcloud'

      microcloud = TenxLabs::Microcloud.new(node["microcloud"]["endpoint"])
      key_data = microcloud.get(:key, user[:key])

      if key_data
        user[:ssh_public_key] = key_data["ssh_public_key"]
      end    
    end

    action :create
  end

  template "/tmp/#{user[:id]}-user_keys" do
    source "user_keys.erb"

    variables(:key => user[:ssh_public_key])
  end
end