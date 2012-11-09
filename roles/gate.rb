name "gate"
description "10xEngineer Gate"
run_list(
  "role[base]",
  "recipe[sudo]",
  "recipe[node]",
  "recipe[10xeng-sshgate]",
  "recipe[10xeng-sshgate::http_proxy]"
)

override_attributes "authorization" => {
  "sudo" => {
    "groups" => ["admin"],
    "users" => ["ubuntu", "mchammer"],
    "passwordless" => true
  }
}
