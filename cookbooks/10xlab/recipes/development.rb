# recipe[10xlab::development]

arch = `/usr/bin/dpkg --print-architecture`
arch = arch.strip()
cache_file = node["10xlab"]["cache"] + "rootfs-cache-" + arch + ".tar.gz"

Chef::Log.info "Preparing cache for arch=#{arch} file=#{cache_file}"

# setup default rootfs-cache
# * local .cache is used to significantly improve `vagrant up` time when re-cycling the box
# * currently supports only one LXC rootfs type (precise/i386)
if File.exists?(cache_file) and !File.exists?("/var/cache/lxc/precise/rootfs-#{arch}")
  Chef::Log.info "Cache file=#{cache_file} for arch=#{arch}"
  script "prepare cache" do
    interpreter "bash"
    user "root"
    cwd "/tmp"
    code <<-EOH
      arch=`/usr/bin/dpkg --print-architecture`
      mkdir -p /var/cache/lxc/precise/rootfs-${arch}
      tar xvfz /vagrant/.cache/rootfs-cache-${arch}.tar.gz -C /var/cache/lxc/precise/
    EOH
  end
else
  Chef::Log.info "Cache file=#{cache_file} for arch=#{arch} doesn't exist"
end
