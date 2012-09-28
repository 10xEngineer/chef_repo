# FIXME move provider to generic webapp or javaapp (only implement provider)
actions :create

attribute :name, :kind_of => String, :name_attribute => true
attribute :version, :kind_of => String

attribute :user, :kind_of => String, :default => "root"
attribute :group, :kind_of => String, :default => "root"