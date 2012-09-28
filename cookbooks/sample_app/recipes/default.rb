include_recipe "java"
include_recipe "tomcat"

user "demo_app" do
	comment "random demo app user"

	uid 1234
	gid "users"
	system true
	shell "/bin/false"
end

tomcat_instance "demo_instance" do
	version "6.0.35"

	user "demo_app"
	group "users"

	action :create	
end

java_app "demo1" do
	action :deploy
end