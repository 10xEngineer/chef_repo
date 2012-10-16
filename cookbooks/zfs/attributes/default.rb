default["zfs"]["repository"] = "http://ppa.launchpad.net/zfs-native/stable/ubuntu/"
default["zfs"]["keyserver"] = "keyserver.ubuntu.com"
default["zfs"]["key"] = "F6B0FC61"

# using expanded list of packages instead of 'ubuntu-zfs', which does not work
# for quantal at the moment
default["zfs"]["packages"] = "spl-dkms spl zfs-dkms zfsutils"
