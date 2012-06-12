# cookbook: lvm
# recipe: default
#

gem_package "di-ruby-lvm" do
  action :nothing
end.run_action(:install)

package "lvm2" do
  action :upgrade
end
