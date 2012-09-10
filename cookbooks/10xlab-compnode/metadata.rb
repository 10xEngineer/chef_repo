maintainer        "Radim Marek"
maintainer_email  "radim@10xengineer.me"
license           "Apache 2.0"
description       "10xLabs Compilation node"
version           "0.1.0"

%w{ ubuntu }.each do |os|
  supports os
end

depends "lvm"
depends "lxc"
depends "10xlab"