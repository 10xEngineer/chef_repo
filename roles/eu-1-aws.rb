name "eu-1-aws"
description "Labs eu-1-aws endpoint"

run_list(
  "role[microcloud]",
  "recipe[10xeng-mc::eu-1-aws]"
)
