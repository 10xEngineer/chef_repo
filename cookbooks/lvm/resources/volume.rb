actions :create

def initialize(*args)
  super
  @action = :create
end

attribute :name, :kind_of => String, :name_attribute => true
attribute :fs_size, :kind_of => String, :required => true
attribute :vg_name, :kind_of => String
