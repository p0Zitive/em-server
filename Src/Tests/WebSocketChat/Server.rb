require 'em-websocket'
 
index = 1
connections = {}
 
def login_names( connections )
  connections.map { |ws, name| name }.join( ", " )
end
 
EM.run do
  EM::WebSocket.run( :host => "0.0.0.0", :port => 8000 ) do |ws|
    ws.onopen do |handshake|
      name  = "Guest#{index}"
      connections[ws] = name
      index += 1
 
      ws.send "[Server] Hello #{name}"
      ws.send "[Server] Members are: #{login_names(connections)}"
    end
 
    ws.onclose do
      connections.delete( ws )
    end
 
    ws.onmessage do |msg|
      sender = connections[ws]
 
      connections.each do |cws, name|
        cws.send "[#{sender}] #{msg}"
      end
    end
  end
end