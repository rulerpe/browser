require 'socket'

server = TCPServer.open(2000)
loop{
client = server.accept
puts "test1"
initial_line = client.gets
p initial_line
puts "test2"
arr_line = initial_line.split
puts "test3"
arr_line[1].delete! "/"
puts "test4"
if File.exists?(arr_line[1])
	file = File.open(arr_line[1],"r")
	client.puts "#{arr_line[2]} 200 OK"
	puts "has file"
	client.puts("Date: " + Time.now.ctime)
	client.puts("Content-Type: text/html")
	content = file.read
	client.puts("Content-Length: #{content.length}")
	
	client.puts (content)
else
	client.puts "#{arr_line[2]} 404 Not Found"
end
client.close
}