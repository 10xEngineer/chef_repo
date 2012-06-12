name "microcloud"
description "10xEngineer microcloud"
run_list(
  "role[base]",
  "recipe[10xeng-mc::default]"
)
