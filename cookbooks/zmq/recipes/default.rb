# cookbook zmq

%w{libzmq1 libzmq-dev}.each do |p|
  package p do
    action :upgrade
  end
end
