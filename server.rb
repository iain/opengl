require 'socket'

dts = TCPServer.new('192.168.0.101', 31337)
@clients = []
@client_matrix = []

loop do
  Thread.start(dts.accept) do |s|
    client_number = @client.size
    @client << s
    while(line = s.gets)
      @client_matrix[client_number] = line
    end
    s.close
  end
end

p @client_matrix
