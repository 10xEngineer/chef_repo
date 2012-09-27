# 10xlabs-base::default

# Nokogiri support
%w{libxml2 libxml2-dev libxslt1-dev}.each do |pkg|
	package pkg do
		action :install
	end
end

gem_package "nokogiri" do
	action :install
end