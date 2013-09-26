#!/usr/bin/ruby
#Chris Wood - A00741285 - COMP7005 - Assignment 1
#descriptionnnn

##### SERVER CODE
default_port = 7005

p = "ftp>"

require 'socket'

server = TCPServer.open(default_port)
loop {
  Thread.start(server.accept) do |client|
    client.puts "#{p} Welcome! You've connected at #{Time.now}"
    client.puts "#{p} Please type HELP for commands"
    while msg = client.gets
	puts msg.chop
    end
    client.close
    end
}




#check invocation and proper usage
#connect

#send

#get

#disconnect


#always error check for api calls (socket creation, socket binding, etc)


