# 10xeng-labnode::ec2_zfs

mount "/mnt" do
  device "/dev/xvdb"
  action [:umount, :disable]
end

zfs_zpool "lxc" do
  physical_volumes node["zfs"]["volumes"]

  action :create
end
