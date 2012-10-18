name "hostnode"
description "10xEngineer hostnode"
run_list(
  "role[base]",
  "recipe[sudo]",
  "recipe[zfs]",
  "recipe[ovs::build]",
  "recipe[node]",
  #"recipe[lvm]",
  "recipe[lxc]",
  "recipe[ruby]",
  "recipe[redis]",
  "recipe[lxc::rootfs-cache]",
  #"recipe[10xlab::default]",
  "recipe[10xlab-admins::default]",
  "recipe[10xeng-node::default]",
  "recipe[10xeng-node::term_serv]",
  #"recipe[10xlab-githost::default]"
)

override_attributes "authorization" => {
  "sudo" => {
    "groups" => ["admin"],
    "users" => ["ubuntu", "mchammer"],
    "passwordless" => true
  }
}
