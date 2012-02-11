class Connection

  attr_accessor :socket

  def initialize *args
    @address, @port, @player_name = *args
    self.socket = TCPSocket.new(@address,@port)

    set_name(@player_name)

    @last_matrice_communication = @last_commands_communication =  Time.now.to_f
  end

  def send line
    self.socket.puts line
  end

  def request line
    send line
    socket.gets
  end

  def set_name player_name
    send("set_name: #{player_name}")
  end

  def request_players_list
    eval(request("request: players"))
  end

  def send_matrix matrix
    send("matrix: #{matrix}")
  end

  def get_player_location id
    eval(request "get: #{id}")
  end

  def request_matrix
    request("request: matrix")
  end

  def send_commands keys
    send("set_commands: #{keys.to_a}")
  end

  def get_player_commands id
    eval(request("get_commands: #{id}"))
  end

  def communicate_matrice?
    if send = (Time.now.to_f - @last_matrice_communication > 0.5)
      @last_matrice_communication = Time.now.to_f
    end
    send
  end

  def communicate_commands?
    if send = (Time.now.to_f - @last_commands_communication > 0.1)
      @last_commands_communication = Time.now.to_f
    end
    send
  end

end

