name "misc"
run_list(
  "recipe[node]",
  "recipe[mongodb]",
  "recipe[zmq]",
  "recipe[runit]"
)
