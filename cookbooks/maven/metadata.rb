maintainer        "Radim Marek"
maintainer_email  "radim@10xengineer.me"
license           "Apache 2.0"
description       "Base package for Maven"
version           "0.1.0"

depends "java"

%w{ubuntu}.each do |os|
	supports os
end