actions :deploy

def initialize(*args)
	super

	@action = :deploy
end

attribute :name, :kind_of => String, :name_attribute => true
# :local for (~/pom.xml), :repository for remote pom.xml (GIT/SVN)
attribute :source, :kind_of => String, :default => :local

# TODO temporary 
attribute :destination, :kind_of=> String