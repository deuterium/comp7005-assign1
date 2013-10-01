#!/usr/bin/ruby
#Chris Wood - A00741285 - COMP7005 - Assignment 1
#Simple FTP server
#Waits for clients to connect and allows the transfer
#of files between server and client.

##### SERVER CODE
##TODO:
### error handling for socket api calls
### logging to a file
### client/server code refactoring for common code base
### error handling if file does not exist
### pattern check for IP and port for ARGV
### add windows support
default_port = 7005
@p = "ftp>"
@t = " >> #{Time.now}"

require 'socket'

#receivefile
#Receives file that a client has requested to send to the server
#and saves it as a file.
def receivefile(c)
    filename = c.gets
    fc = ""
    while 1
        li = c.gets
        break if li.include? "CMD_EOF"
        fc << li
    end
    path = `pwd`
    File.open "#{path.chomp}/#{filename.chomp}","wb" do |file|
        file.print fc
    end
    #send success
    c.puts "CMD_SCS"
    log "#{@remote_ip} XFER IN #{filename.chomp}"
end

#sendfile
#Opens specified file from the directory that the sever is running
#from and sends it to the requesting client.
def sendfile(c)
    filename = c.gets
    begin 
        path = `pwd`
        fullpath = "#{path.chomp}/#{filename.chomp}"
        #fd = open "#{fullpath.chomp}","rb"
        File.open "#{fullpath.chomp}","rb" do |file|
            #while chunk = file.read(50000)
            #    puts chunk
            #    c.puts chunk
            #end
            fc = file.readlines
            c.puts fc
        end
        #fc = fd.read
        #c.puts fc
        #sleep 5
        c.puts "CMD_EOF"
        log "#{@remote_ip} XFER OUT #{filename.chomp}"
    rescue :ENOENT => err
        puts "file does not exist"
        #c.puts "CMD_ERR"
    ensure
        #fd.close    
    end
end

#listfiles
#Sends directory listing to requesting client.
def listfiles(c)
    c.puts `ls`
    c.puts "CMD_END"
end

#log
#Verbose logging for the server
#Currently outputs to terminal only
def log(msg)
    puts "log>> " + msg + @t
end


#start logic
##cmdline arguments for another port
if ARGV.count > 1
    puts "Proper usage: ./server [listening_port]"
    exit
elsif ARGV.empty?
    port = default_port
else
    port = ARGV[0]
    ARGV.clear
end

server = TCPServer.open(port)
loop {
    Thread.start(server.accept) do |client|
        sock_domain, remote_port, 
            remote_hostname, @remote_ip = client.peeraddr
        client.puts "#{@p} Welcome! You've connected at #{Time.now}"
        client.puts "#{@p} Please type HELP for commands"
        log "#{@remote_ip} has connected"
        while msg = client.gets.chomp
            log "#{@remote_ip} #{msg}"
            case msg
            when "CMD_LIST"
                listfiles client
            when "CMD_DC"
                break
            when "CMD_GET"
                sendfile client
            when "CMD_PUT"
                receivefile client
            else 
                puts msg + @t
            end
        end
        log "#{@remote_ip} has disconnected"
        client.close        
    end
}

