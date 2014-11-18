require 'socket'
require 'json'

hostname = 'localhost'
port = 2000
index_path = "/index.html"
post_path = "/thanks.html"

s = TCPSocket.open(hostname,port)
print "1,GET or 2,POST: "
chossice = gets.chomp
if chossice == '1'
#	request = "Get #{index_path} HTTP/1.0\r\n\r\n"
	get = {:r => "Get #{index_path} HTTP/1.0\r\n\r\n"}
	puts get[:r]
	s.print get.to_json
	s.print "\n"
	
else
	viking = Hash.new
	print "please enter your name: "
	name = gets.chomp
	print "enter your email: "
	email = gets.chomp
	request ="POST #{post_path} HTTP/1.0\r\n\r\n"
	viking = {:r => request, :viking => {:name => name, :email => email}}
	s.print(viking.to_json + "\n")


end
while line = s.gets   # Read lines from the socket
  puts line.chop      # And print with platform line terminator
end
s.close