name "compile"
description "10xLabs compiler node (first version)"

run_list(
  "role[base]",
  "recipe[10xlab-compile]"
)