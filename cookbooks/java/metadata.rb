maintainer        "Radim Marek"
maintainer_email  "radim@10xengineer.me"
license           "Apache 2.0"
description       "Base package for Java/JVM applications"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "0.1.0"

recipe "java", "Installs and manage Java runtime"

%w{ubuntu}.each do |os|
	supports os
end