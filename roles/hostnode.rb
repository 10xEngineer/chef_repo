name "hostnode"
description "10xEngineer hostnode"
run_list(
  "role[base]",
  "recipe[sudo]",
  "recipe[node]",
  "recipe[lvm]",
  "recipe[lxc]",
  "recipe[ruby]",
  "recipe[lxc::rootfs-cache]",
  "recipe[10xlab::default]",
  "recipe[10xeng-node::default]"
)

override_attributes "authorization" => {
  "sudo" => {
    "groups" => ["admin"],
    "users" => ["mchammer"],
    "passwordless" => true
  }
}
