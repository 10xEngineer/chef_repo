default["java"]["flavor"] = "openjdk"
default["java"]["version"] = 6
default["java"]["arch"] = kernel['machine'] =~ /x86_64/ ? "x86_64" : "i586"
