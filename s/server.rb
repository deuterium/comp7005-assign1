#!/usr/bin/ruby
#Chris Wood - A00741285 - COMP7005 - Assignment 1
#descriptionnnn

##### SERVER CODE
default_port = 7005

@p = "ftp>"
@t = " >> #{Time.now}"

require 'socket'
def getfile(filename)
    puts "server sendfile"
end
def sendfile(c)
    filename = c.gets
    begin 
        path = `pwd`
        fullpath = "#{path.chomp}/#{filename.chomp}"
        puts fullpath
        #fd = open "#{fullpath.chomp}","rb"
        File.open "#{fullpath.chomp}","rb" do |file|
            #while chunk = file.read(50000)
            #    puts chunk
            #    c.puts chunk
            #end
            chunk = file.readlines
            c.puts chunk
        end

        #fc = fd.read
        #c.puts fc
        #sleep 5
        c.puts "CMD_EOF"
        log "#{@remote_ip} XFER #{filename.chomp}"
    rescue :ENOENT => err
        puts "file does not exist"
        #c.puts "CMD_ERR"
    ensure
        #fd.close    
    end
end
def listfiles(c)
    c.puts `ls`
    c.puts "CMD_END"
end
def log(msg)
    puts "log>> " + msg + @t
end

server = TCPServer.open(default_port)
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
            else 
                puts msg + @t
            end
        end
        log "#{@remote_ip} has disconnected"
        client.close
        
    end
}




#check invocation and proper usage
#connect

#send

#get

#disconnect


#always error check for api calls (socket creation, socket binding, etc)


