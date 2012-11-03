name "base"
run_list(
  "recipe[apt]",
  "recipe[git]",
  "recipe[10xeng-hosts]"
)
