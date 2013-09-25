#!/usr/bin/ruby
#Chris Wood - A00741285 - COMP7005 - Assignment 1
#descriptionnnn

##### CLIENT CODE
default_port = 7005
localhost = "127.0.0.1"


require 'socket'

s = TCPSocket.open(localhost, default_port)

while line = s.gets
puts line.chop
end
s.close



#check invocation and proper usage
#connect

#send

#get

#disconnect


#always error check for api calls (socket creation, socket binding, etc)


