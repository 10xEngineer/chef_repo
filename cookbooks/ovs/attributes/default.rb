ovs_version = "1.7.1"

default["ovs"]["version"] = ovs_version
default["ovs"]["distribution"] = "http://openvswitch.org/releases/openvswitch-#{ovs_version}.tar.gz"

# configuration
default["ovs"]["brcompat"] = true