name "compile"
description "10xLabs compiler node (v2)"

run_list(
  "role[base]",
  "recipe[10xlab-admins]",
  "recipe[10xlab-compnode]"
)