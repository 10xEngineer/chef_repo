default["lxc"]["location"] = "/var/lib/lxc"

default["lxc"]["arch"] = "i386"
default["lxc"]["cache"] = "/var/cache/lxc"
default["lxc"]["release"] = node["lsb"]["codename"]
default["lxc"]["templates"] = ["ubuntu"]

default["lxc-template"]["ubuntu"]["components"] = ["main","universe"]
default["lxc-template"]["ubuntu"]["packages"] = %W{dialog apt apt-utils iproute inetutils-ping vim isc-dhcp-client isc-dhcp-common ssh lsb-release gnupg netbase ubuntu-keyring}
