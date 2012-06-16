# cookbook gateone

# install dependencies
node["gateone"]["dependencies"].each do |p|
  package p do
    action :upgrade
  end
end

# install distribution packages bundled with the cookbook
node["gateone"]["packages"].each do |p|
  cookbook_file "/tmp/#{p}" do
    source p
    mode "0644"
  end

  package p do
    provider Chef::Provider::Package::Dpkg
    source "/tmp/#{p}"
    action :install
  end
end
