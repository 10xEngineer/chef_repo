name "hostnode"
description "10xEngineer hostnode"
run_list(
  "role[base]",
  "recipe[sudo]",
  "recipe[zfs]",
  #"recipe[ovs::build]",
  "recipe[node]",
  #"recipe[lvm]",
  "recipe[lxc]",
  "recipe[ruby]",
  #"recipe[redis]",
  "recipe[revealcloud]",
  "recipe[lxc::rootfs-cache]",
  #"recipe[10xlab::default]",
  "recipe[10xlab-admins::default]",
  "recipe[10xeng-node::default]",
  "recipe[10xeng-node::iptables]",
  "recipe[10xeng-node::http_proxy]"
)

override_attributes "authorization" => {
  "sudo" => {
    "groups" => ["admin"],
    "users" => ["ubuntu", "mchammer"],
    "passwordless" => true
  },
  "copperegg" => {
    "apikey" => "iv9MlKU7LKh65P4A"
  }
}
