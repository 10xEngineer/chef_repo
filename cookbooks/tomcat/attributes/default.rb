# attributes/default.rb

default["tomcat"]["version"] = "6.0.35"
default["tomcat"]["sources"] = {
	"6.0.35" => {
		:download_url => "http://mirror.hosting90.cz/apache/tomcat/tomcat-6/v6.0.35/bin/apache-tomcat-6.0.35.tar.gz",
		:md5sum => "b28c9cbc2a8ef271df646a50410bab7904953b550697efb5949c9b2d6a9f3d53"
	},
	"7.0.30" => {
		:download_url => "http://apache.miloslavbrada.cz/tomcat/tomcat-7/v7.0.30/bin/apache-tomcat-7.0.30.tar.gz",
		:md5sum => "65cc0ef5c9742e89788d1d5938eac1b0b984dcea298119a6bf856612854b9dbe"
	}
}