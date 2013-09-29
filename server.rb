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
def listfiles
    puts "server listfiles"
end
def log(msg)
    puts "log>> " + msg + @t
end

server = TCPServer.open(default_port)
loop {
    Thread.start(server.accept) do |client|
        client.puts "#{@p} Welcome! You've connected at #{Time.now}"
        client.puts "#{@p} Please type HELP for commands"
        while msg = client.gets.chomp
            log(msg)

            case msg
            when "CMD_LIST"
                client.puts `ls`
                client.puts "CMD_END"
            when "CMD_DISCONNECT"
                break
            else 
                puts msg + @t
            end
        end
        client.close
        puts "client disconnected"
    end
}




#check invocation and proper usage
#connect

#send

#get

#disconnect


#always error check for api calls (socket creation, socket binding, etc)


