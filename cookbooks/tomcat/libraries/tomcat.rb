module Tomcat
	def version_parser(version) 
		m = version.match /^(\d+\.)?(\d+\.)?(\*|\d+)?$/

		return {
			:major => m[1].to_i,
			:minor => m[2].to_i,
			:build => m[3].to_i
		}
	end

	module_function :version_parser
end