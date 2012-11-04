maintainer        "Radim Marek"
maintainer_email  "radim@10xengineer.me"
license           "Apache 2.0"
description       "Platform API"
version           "0.1.0"

%w{ ubuntu }.each do |os|
  supports os
end

depends "10xeng-code"
depends "runit"