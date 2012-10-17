# zpool provider
include Chef::Mixin::ShellOut

action :create do
  unless exists?
    command = ["zpool", "create"]
    command << "-R #{new_resource.mountpoint}" if new_resource.mountpoint
    command << new_resource.name
    command << new_resource.physical_volumes.join(' ')

    Chef::Log.info command

    system(command.join(' '))
    new_resource.updated_by_last_action(true)
  end
end

def info
  shell_out("zpool list #{new_resource.name}")
end

def exists?
  info.exitstatus == 0
end
