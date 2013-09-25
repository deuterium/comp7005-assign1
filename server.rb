#!/usr/bin/ruby
#Chris Wood - A00741285 - COMP7005 - Assignment 1
#descriptionnnn

##### SERVER CODE
default_port = 7005

require 'socket'

server = TCPServer.open(default_port)
loop {
  Thread.start(server.accept) do |client|
    client.puts "hello!"
    client.puts "Time is #{Time.now}"
    client.close
    end
}




#check invocation and proper usage
#connect

#send

#get

#disconnect


#always error check for api calls (socket creation, socket binding, etc)


