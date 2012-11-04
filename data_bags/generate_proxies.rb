#!/usr/bin/env ruby

def rand_hexstring(length=8)
  ((0..length).map{rand(256).chr}*"").unpack("H*")[0][0,length]
end

uid = 1700


users = []
(1..50).each do |index|
	token = rand_hexstring(5)

	user = "lab-#{token}"

	uid = uid + 1

	data = "{\"id\": \"#{user}\", \"uid\": #{uid}}"

	File.open("ssh_proxies/#{user}.json", 'w') { |f| f.puts data}

	users << user
end

puts users.inspect
