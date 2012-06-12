maintainer        "Radim Marek"
maintainer_email  "radim@opsfactory.com"
license           "Apache 2.0"
description       "Manage LVM volumes"
version           "0.1.0"

#recipe "lvm", "Installs lvm2 package"

%w{ ubuntu }.each do |os|
  supports os
end
