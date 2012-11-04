name "manage_app"
description "10xEngineer hostnode"
run_list(
  "role[base]",
  "recipe[ruby]",
  "recipe[10xeng-manage]"
)