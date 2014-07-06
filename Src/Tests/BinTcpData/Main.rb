require 'socket'
require 'bindata'
require 'hex_string'
require 'eventmachine'

 
class CustomProtocol < BinData::Record
    endian  :little
    stringz :command_word
    uint8   :op1
    uint8   :op2
end


def MakeRequest( cmd, a, b )
  request = CustomProtocol.new
  request.command_word = cmd
  request.op1 = a
  request.op2 = b
  request
end

 
module GwServer
  class GwTcpClient < EventMachine::Connection
    def notify_readable 
        received_data = @io.read_nonblock( 4096 )
        puts "INFO: notify_readable() => #{received_data.inspect}" 
        # Just for testing purposes: 
        sleep 1
    end
    

    def post_init    
        request = MakeRequest( 'Add', 48, 65 )
        requestData = request.to_binary_s

        puts "sending request to server: #{requestData.to_hex_string}"
        send_data requestData
    end
    

    def receive_data data
       puts "recvs: #{data}"
    end
  end
  

  class GwDataServer < EM::Connection
    attr_accessor :server_socket    
  

    def post_init      
        numConnection = EventMachine.connection_count
        puts "Server post init: connection count = #{numConnection}"
    end
    

    def receive_data data
      port, ip = Socket.unpack_sockaddr_in( get_peername )
      puts "recieve data (#{ip}): #{data.to_hex_string}"
 
      send_data ">>>you sent: #{data.to_hex_string}"
    end
    

    def send_data_to_tcpserver data
      @server_socket.puts "#{data}"      
    end
    

    def get_message_from_tcp_server  
    end
  end
  
  
  def self.run
    EM.run do 
      puts "dataServer running..."
      EM.start_server( "0.0.0.0", 3000, GwDataServer )

      EventMachine::connect '127.0.0.1', 3000, GwTcpClient
      EventMachine::connect '127.0.0.1', 3000, GwTcpClient
      EventMachine::connect '127.0.0.1', 3000, GwTcpClient
    end
  end
end


GwServer.run
