require 'socket'

hostname = 'localhost'
port = 2000
path = "/index.html"


s = TCPSocket.open(hostname,port)
puts "test1"
request = "Get #{path} HTTP/1.0\r\n\r\n"
puts "test2"
s.print(request)
puts "test3"
while line = s.gets   # Read lines from the socket
  puts line.chop      # And print with platform line terminator
end
s.close