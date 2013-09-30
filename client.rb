#!/usr/bin/ruby
#Chris Wood - A00741285 - COMP7005 - Assignment 1
#descriptionnnn

##### CLIENT CODE
default_port = 7005
localhost = "127.0.0.1"
@p = "ftp>"

require 'socket'
def sendfile(filename)
    @s.puts "CMD_PUT"
    puts "sendfile called"
end
def getfile(filename)
    listfiles
    puts "#{@p} What file do you want?"
    @s.puts "CMD_GET"
    filename = gets
    @s.puts filename
    ##
    ## Probably need an error check if the file exists on the server
    ## and can be sent
    ##
    fc = ""
    while 1
        li = @s.gets
        break if li.include? "CMD_EOF"
        fc << li
    end
    path = `pwd`
    fd = File.open "#{path.chomp}/#{filename.chomp}","wb"
    fd.print fc
    fd.close
    puts "#{@p} File received. Enter another command"
    
end
def listfiles
    @s.puts "CMD_LIST"
    msg = ""
    while line = @s.gets
        if line.chomp.eql? "CMD_END"
            break
        end
        msg += line 
    end
    puts "#{@p} #{msg.tr "\n"," "}"
end
def help
    puts "#{@p} Commands available: LIST PUT GET EXIT"
end
def disconnect
    @s.puts "CMD_DC"
    puts "#{@p} Disconnecting from server"
end 


#connect to to server
@s = TCPSocket.open(localhost, default_port)
##needs error handling

#server welcome message
puts @s.gets.chomp
puts @s.gets.chomp

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
        disconnect
        break
    else 
        puts "#{@p} invalid command"
    end 
end

@s.close



#check invocation and proper usage
#connect

#send

#get

#disconnect


#always error check for api calls (socket creation, socket binding, etc)


