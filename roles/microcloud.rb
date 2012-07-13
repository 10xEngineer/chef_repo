name "microcloud"
description "10xEngineer microcloud"

run_list(
  "role[base]",
  "recipe[nginx]",
  "recipe[runit]",
  "recipe[ruby]",
  "recipe[node]",
  "recipe[mongodb]",
  "recipe[zmq]",
  "recipe[10xeng-mc::default]"
)