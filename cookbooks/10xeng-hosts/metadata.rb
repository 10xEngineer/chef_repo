maintainer        "Radim Marek"
maintainer_email  "radim@10xengineer.me"
license           "Apache 2.0"
description       "Internal 10xEngineer infrastructure nodes"
version           "0.1.0"

%w{ ubuntu }.each do |os|
  supports os
end
