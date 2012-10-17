default["zfs"]["repository"] = "http://ppa.launchpad.net/zfs-native/stable/ubuntu/"
default["zfs"]["keyserver"] = "keyserver.ubuntu.com"
default["zfs"]["key"] = "F6B0FC61"

# using expanded package list, instead of 'ubuntu-zfs'
default["zfs"]["packages"] = %w{spl-dkms spl zfs-dkms zfsutils}

if node["ec2"]
	default["zfs"]["volumes"] = ["/dev/xvdb"]
else
	default["zfs"]["volumes"] = ["/dev/sdb"]
end