# cookbook 10xeng-mc

# ruby dependencies
%w{build-essential libxml2-dev libxslt-dev}.each do |p|
  package p do
    action :upgrade
  end
end

# node dependencies
%w{pkg-config uuid uuid-dev}.each do |p|
  package p do
    action :upgrade
  end
end
