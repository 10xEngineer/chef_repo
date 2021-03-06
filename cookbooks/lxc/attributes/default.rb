default["lxc"]["location"] = "/var/lib/lxc"

default["lxc"]["arch"] = "i386"
default["lxc"]["cache"] = "/var/cache/lxc"
default["lxc"]["release"] = node["lsb"]["codename"]
default["lxc"]["templates"] = ["ubuntu"]

default["lxc-template"]["ubuntu"]["components"] = ["main","universe"]

#
# build fsrootcache from as many package as possible
#
default["lxc-template"]["ubuntu"]["packages"] = %W{apt apt-utils iproute 
													inetutils-ping vim isc-dhcp-client 
													isc-dhcp-common ssh lsb-release gnupg netbase 
													ubuntu-keyring git curl 
													ruby1.9.3 ruby1.9.1-dev build-essential vim}

