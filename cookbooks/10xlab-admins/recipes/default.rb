# 10xlabs::admins

chef_gem "ruby-shadow" do
  action :install
end

admins = data_bag('admins')
admins.each do |uid|
  u = data_bag_item('admins', uid)

  home_dir = "/home/#{u["id"]}"

  user u["id"] do
    comment u["full_name"]
    uid u["uid"]
    gid u["groups"].first
    home home_dir
    shell u["shell"]

    # Y6PB7TvXz6ck7uPH
    password "$1$Z4iVkLtC$Axq1ayUCSCyurGfqT37IM/"

    supports :manage_home => false
  end

  directory home_dir do
    owner u["id"]
    group u["groups"].first
    mode "0755"

    action :create
  end

  directory "#{home_dir}/.ssh" do
    owner u["id"]
    group u["groups"].first
    mode "0700"

    action :create
  end

  template "/home/#{u['id']}/.ssh/authorized_keys" do
    owner u["id"]
    group u["groups"].first
    mode "0600"

    variables :key => u["ssh_key"]

    action :create
  end
end