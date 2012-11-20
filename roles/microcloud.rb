name "microcloud"
description "10xEngineer Labs Microcloud"

run_list(
  "role[base]",
  "recipe[tarsnap]",
  "recipe[nginx]",
  "recipe[runit]",
  "recipe[ruby]",
  "recipe[node]",
  "recipe[mongodb]",
  "recipe[zmq]",
  "recipe[10xeng-mc::default]"
)

override_attributes(
	"microcloud" => {"environment" => "production"}
)
