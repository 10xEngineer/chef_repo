maintainer        "Radim Marek"
maintainer_email  "radim@10xengineer.me"
license           "Apache 2.0"
description       "Sample lab cookbook - testing only"
version           "0.1.0"

depends "java"
depends "tomcat"

%w{ubuntu}.each do |os|
	supports os
end
