name "githost"
description "10xLabs git repo hosting node"

run_list(
  "role[base]",
  "recipe[10xlab-githost]"
)