maintainer        "Radim Marek"
maintainer_email  "radim@10xengineer.me"
license           "Apache 2.0"
description       "10xEngineer Labs codebase"
version           "0.1.0"

depends "node"
depends "zmq"
depends "mongodb"

%w{ ubuntu }.each do |os|
  supports os
end
