require 'socket'

if ARGV.length == 0
    puts "enter the host ip"
    return 1
end
socket = TCPSocket.new(ARGV[0], ARGV[1])
if !socket
    puts "connection error"
    return 1
end
puts "connected"
begin
    while line = socket.gets
        puts line
        if line == "your turn\n"
            ind = $stdin.gets.chomp
            socket.puts ind
        end
    end
rescue
    puts "an error has occured"
ensure
    socket.close
end
