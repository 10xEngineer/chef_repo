maintainer        "Radim Marek"
maintainer_email  "radim@opsfactory.com"
license           "Apache 2.0"
description       "Install and manage VirtualBox"
#long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "0.1.0"

recipe "virtualbox", "Installs and manage VirtualBox runtime"

depends "apt"

%w{ubuntu}.each do |os|
	supports os
end