# Microcloud API endpoint to use
# TODO shared configuration for test environment
default["microcloud"]["endpoint"] = nil

default["10xeng-node"]["token"] = nil
default["10xeng-node"]["id"] = nil

default["10xeng-node"]["toolchain"]["version"] = "1.2.0"
default["10xeng-vm"]["packages"] = %W{ssh vim git curl lxc
									  ruby1.9.3 build-essential}

default["http_proxy"]["version"] = "0.1"