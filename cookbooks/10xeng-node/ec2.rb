# cookbook 10xeng
# recipe ec2


# prepare LVM environment
lvm_vg "lxc" do
  physical_volumes ["/dev/xvdb"]

  action :nothing
end

mount "/mnt" do
  device "/dev/xvdb"
  action [:unmount, :disable]

  notifies :action => :create, "lvm_vg[lxc]"
end


# TODO remove from fstab
