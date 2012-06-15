# lvm_vg provider

def create_vg(new_resource)
  require 'lvm'

  lvm = LVM::LVM.new(:command => "/usr/bin/sudo /sbin/lvm")

  group = lvm.volume_groups[new_resource.name]
  unless group
    Chef::Log.info "Creating new volume group '#{new_resource.name}'"

    lvm.raw "vgcreate #{new_resource.name} #{new_resource.physical_volumes.join(' ')}"

    new_resource.updated_by_last_action(true)
  else
    # TODO add/remove physical devices from the group
  end
end

action :create do
  create_vg(new_resource)
end
