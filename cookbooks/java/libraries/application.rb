module JavaApplication
	def application_spec(location)
		require 'nokogiri'

		pom_file = File.join(location, 'pom.xml')

		pom_xml = Nokogiri::XML(File.open(pom_file))
		pom_xml.remove_namespaces!

		artifactId = pom_xml.xpath("/project/artifactId")[0].children[0].text
		version = pom_xml.xpath("/project/version")[0].children[0].text
		packaging = pom_xml.xpath("/project/packaging")[0].children[0].text

		{
			:artifactId => artifactId,
			:version => version,
			:packaging => packaging
		}
	end
end