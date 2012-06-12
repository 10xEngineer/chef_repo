actions :create

def initialize(*args)
  super
  @action = :create
end

attribute :name,                  :kind_of => String, :name_attribute => true
attribute :physical_volumes,      :kind_of => Array

