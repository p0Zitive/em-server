require 'hex_string'
require_relative 'protocol'


def MakeRequest( cmd, a, b )
	request = CustomProtocol.new
	request.command_word = cmd
	request.op1 = a
	request.op2 = b
	request
end


def PrintRequest( request )
	outputArrayString = request.to_binary_s
	puts "Binary data: #{outputArrayString.to_hex_string}"
end


request = MakeRequest( "HandShake", 65, 48 )
PrintRequest( request )