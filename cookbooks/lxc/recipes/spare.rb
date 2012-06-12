# TODO vagrant only - attribute driven?
# TODO move to provisioning recipe (microcloud?)
lvm_vg "precise32-mc" do
  physical_volumes ["/dev/sda5"]
end

# TODO lookup volumes from databag
["vm4"].each do |vol|
  execute "mkfs" do
    command "/sbin/mkfs -t ext4 /dev/precise32-mc/#{vol}"

    action :nothing
  end

  lvm_volume vol do
    fs_size "1GB"
    vg_name "precise32-mc"

    action :create

    notifies :run, 'execute[mkfs]', :immediately
  end

end

#lvm_vg "lxc" do
#  physical_volumes ["/dev/sdb"]
#end
