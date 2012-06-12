# lvm_lv provider

def create_lv(new_resource)
  require 'lvm'

  lvm = LVM::LVM.new(:command => "/usr/bin/sudo /sbin/lvm")

  group = lvm.volume_groups[new_resource.vg_name]
  raise "Invalid volume group '#{new_resource.vg_name}'" unless group

  volume = group.logical_volumes.find {|vol| vol.name == new_resource.name}
  unless volume
     Chef::Log.info "Creating new logical volume '#{new_resource.name}'"

     lvm.raw "lvcreate -L #{new_resource.fs_size} -n #{new_resource.name} #{new_resource.vg_name}"

     # TODO move as standalone resource trigger at the end of the run
     # default action :none and send notification from lvm_volume
     execute "/sbin/udevadm settle" do
       action :run
     end

     new_resource.updated_by_last_action(true)
  else
    # TODO resize? or change volume when needed
    Chef::Log.info "Logical volume '#{name}' already exists."
  end
end

action :create do
  create_lv(new_resource)
end
