#!/usr/bin/ruby
#Chris Wood - A00741285 - COMP7005 - Assignment 1
#descriptionnnn

##### CLIENT CODE
default_port = 7005
localhost = "127.0.0.1"
@p = "ftp>"

require 'socket'
def sendfile(filename)
    puts "sendfile called"
end
def getfile(filename)
    puts "getfile called"
end
def listfiles
    puts "listfiles called"
end
def help
    puts "help called"
end
def disconnect(srv)
    srv.puts "&disconnect%"
    puts "#{@p} Disconnecting from server"
end 


#connect to to server
s = TCPSocket.open(localhost, default_port)
##needs error handling

#server welcome message
puts s.gets.chop

#prompt for input from client
while 1
    cmd = gets.chomp.strip.downcase
    case cmd
    when "list"
        listfiles
    when "put"
        sendfile "temp"
    when "get"
        getfile "temp"
    when "help"
        help
    when "exit"
        disconnect s
        break
    else 
        puts "#{p} invalid command"
    end 
end

s.close



#check invocation and proper usage
#connect

#send

#get

#disconnect


#always error check for api calls (socket creation, socket binding, etc)


