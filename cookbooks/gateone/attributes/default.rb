default["gateone"]["dependencies"] = ["python-support"]
default["gateone"]["packages"] = ["python-tornado_2.2-1_all.deb"]

default["gateone"]["auth"] = nil
default["gateone"]["users_dir"] = "/opt/gateone/users"

default["gateone"]["commit"] = "324ca08"

# configuration parameters
# TODO command
# TODO syslog_host once the logging strategy is in place
# TODO cookie_secret (generate random)

depends "python"
