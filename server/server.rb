require 'socket'
require 'json'
require 'erb'

server = TCPServer.open(2000)
index_path = "index.html"
post_path = "thanks.html"
loop{
client = server.accept

initial_line = client.gets
p initial_line
from = JSON.parse(initial_line)
#from.each{|key,value| puts "#{key},#{value}"}
p from['r']
arr_line =from['r'].lines.first.split
arr_line[1].delete! "/"
if File.exists?(arr_line[1])
	puts arr_line[1]
	file = File.open(arr_line[1],"r")
	client.puts "#{arr_line[2]} 200 OK"
	puts "has file"
	client.puts("Date: " + Time.now.ctime)
	client.puts("Content-Type: text/html")
	content = file.read
	if arr_line[1] == index_path
		client.puts("Content-Length: #{content.length}")
		client.puts (content)
	elsif arr_line[1] == post_path
		f = File.read(arr_line[1])
		erb_template = ERB.new f
		name = from['viking']['name']
		email = from['viking']['email']
		form_letter = erb_template.result(binding)
		client.puts (form_letter)
	end
		
else
	client.puts "#{arr_line[2]} 404 Not Found"
end
client.close
}