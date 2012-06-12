name "hostnode"
description "10xEngineer hostnode"
run_list(
  "recipe[sudo]",
  "recipe[node]",
  "recipe[lvm]",
  "recipe[lxc]",
  "recipe[lxc::rootfs-cache]",
  "recipe[mc-node::default]"
)

override_attributes "authorization" => {
  "sudo" => {
    "groups" => ["admin"],
    "users" => ["mchammer"],
    "passwordless" => true
  }
}
