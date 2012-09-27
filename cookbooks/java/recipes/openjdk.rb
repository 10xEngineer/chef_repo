# java::openjdk
jdk_version = node['java']['version']

packages = value_for_platform(
	["ubuntu", "debian"] => {
		"default" => ["openjdk-#{jdk_version}-jdk"]
	}
)

ruby_block "update-java-alternatives" do
	block do 
		java_name = "openjdk-#{jdk_version}-jdk"
		Chef::ShellOut.new("update-java-alternatives","-s", "java_name", :returns => [0,2]).run_command
	end

	action :nothing
end

packages.each do |pkg|
	package pkg do
		action :install

		notifies :create, "ruby_block[update-java-alternatives]"
	end
end