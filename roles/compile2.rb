name "compile2"
description "10xLabs compiler node (v2)"

run_list(
  "role[base]",
  "recipe[10xlab-admins]",
  "recipe[sudo]",
  "recipe[10xlab-compnode]"
)

override_attributes "authorization" => {
  "sudo" => {
    "groups" => ["admin"],
    "users" => ["compile"],
    "passwordless" => true
  }
}
