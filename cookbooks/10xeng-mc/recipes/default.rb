# cookbook 10xeng-mc

# ruby dependencies
%w{libxml2-dev libxslt-dev}.each do |p|
  package p do
    action :upgrade
  end
end
