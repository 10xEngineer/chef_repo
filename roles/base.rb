name "base"
run_list(
  "recipe[apt]",
  "recipe[git]"
)

override_attributes "monit" => {
  "start_delay" => 15,
  "interval" => 30,
  "web" => {
    :enabled => true
  }
}
