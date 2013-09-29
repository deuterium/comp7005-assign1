#!/usr/bin/ruby
#Chris Wood - A00741285 - COMP7005 - Assignment 1
#descriptionnnn

##### SERVER CODE
default_port = 7005

@p = "ftp>"
@t = " >> #{Time.now}"

require 'socket'
def sendfile(filename)
    puts "server sendfile"
end
def getfile(filename)
    puts "server getfile"
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
            remote_hostname, remote_ip = client.peeraddr
        client.puts "#{@p} Welcome! You've connected at #{Time.now}"
        client.puts "#{@p} Please type HELP for commands"
        log "#{remote_ip} has connected"
        while msg = client.gets.chomp
            log "#{remote_ip} #{msg}"
            case msg
            when "CMD_LIST"
                listfiles client
            when "CMD_DC"
                break
            else 
                puts msg + @t
            end
        end
        log "#{remote_ip} has disconnected"
        client.close
        
    end
}




#check invocation and proper usage
#connect

#send

#get

#disconnect


#always error check for api calls (socket creation, socket binding, etc)


