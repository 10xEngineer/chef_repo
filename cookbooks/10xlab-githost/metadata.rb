maintainer        "Radim Marek"
maintainer_email  "radim@10xengineer.me"
license           "Apache 2.0"
description       "10xLab git hosting setup"
version           "0.0.1"

%w{ ubuntu }.each do |os|
  supports os
end

depends "git"