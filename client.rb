#!/usr/bin/ruby
#Chris Wood - A00741285 - COMP7005 - Assignment 1
#Simple FTP client
#Connects to specified server and allows transfer of
#files between the client and server.

##### CLIENT CODE
##TODO: 
### error handling for socket api calls
### "get filename" rather than "get" then "filename"
### above but for "put"
### fix behavior with filetypes (non- text, mp3, picture)
default_port = 7005
localhost = "127.0.0.1"
@p = "ftp>"

require 'socket'

#sendfile
#Opens specified file from directory this program was run in
#and sends it to the server.
def sendfile(filename)
    @s.puts "CMD_PUT"
    puts "sendfile called"
end

#getfile
#Requests specified file from server, receives it and saves it 
#in directory this program was run in.
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

#listfiles
#Requests a file list from the server
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

#help
#Shows client available commands
def help
    puts "#{@p} Commands available: LIST PUT GET EXIT"
end

#disconnect
#Sends disconnection notice to server, closes down connection
#on clientside and ends the program.
def disconnect
    @s.puts "CMD_DC"
    puts "#{@p} Disconnecting from server"
end 

#cmd line arguments


#connect to to server
@s = TCPSocket.open(localhost, default_port)
##needs error handling

#server welcome messages
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

