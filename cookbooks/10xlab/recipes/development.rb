# recipe[10xlab::development]

# setup default rootfs-cache
# * local .cache is used to significantly improve `vagrant up` time when re-cycling the box
# * currently supports only one LXC rootfs type (precise/i386)
if File.exists? "/vagrant/.cache/rootfs-cache-i386.tar.gz" and !File.exists? "/var/cache/lxc/precise/rootfs-i386"  
  script "prepare cache" do
    interpreter "bash"
    user "root"
    cwd "/tmp"
    code <<-EOH
      mkdir -p /var/cache/lxc/precise/rootfs-i386
      tar xvfz /vagrant/.cache/rootfs-cache-i386.tar.gz -C /var/cache/lxc/precise/
    EOH
  end
end