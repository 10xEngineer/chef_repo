# Microcloud API endpoint to use
# TODO shared configuration for test environment
default["microcloud"]["endpoint"] = nil

default["10xeng-node"]["token"] = nil
default["10xeng-node"]["id"] = nil

default["10xeng-node"]["toolchain"]["version"] = "0.0.15"
default["10xeng-vm"]["packages"] = %W{ssh vim git curl lxc
									  ruby1.9.3 build-essential}

default["10xeng-lxc"]["bootstrap"]["version"] = "0.5_all"
default["10xeng-lxc"]["node_serv"]["version"] = "0.1_all"
default["10xeng-lxc"]["term_serv"]["version"] = "0.1_all"
