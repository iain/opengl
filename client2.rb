PORT = 5535
NAME = ARGV.shift or "Anon"

chat_client = TCPSocket.new("192.168.0.101", PORT)
while(line = chat_client.gets)
  p line
end
