maintainer        "Radim Marek"
maintainer_email  "radim@opsfactory.com"
license           "Apache 2.0"
description       "Microcloud host node management"
version           "0.1.0"

%w{ ubuntu }.each do |os|
  supports os
end

depends "lvm"
depends "lxc"
depends "10xlab"