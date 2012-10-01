module Tomcat
	def version_parser(version) 
		m = version.match /^(\d)?.?(\d+)?.?(\d+)?/
		versions = m.captures.map {|m| m ? m : "0"}

		return {
			:major => m[0].to_i,
			:minor => m[1].to_i,
			:build => m[2].to_i
		}
	end

	module_function :version_parser
end
