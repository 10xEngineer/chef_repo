# Microcloud host node

## VM Provisioning

Right now individual VM (LXC containers) are provisioned using `lxc-create` and predefined templates. Default template `ubuntu` has been extended to support custom packages install set.

**TODO** Extend supported vm-types
**TODO** Better template distribution mechanism (might involve lxc-create replacement)
**TODO** better way how to install packages - right now patch within `download_ubuntu`


