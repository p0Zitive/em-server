from ctypes import *

class CustomProtocol( Structure ):
	_fields_ = [( "command_word", c_char_p ), ( "op1", c_uint8 ), ( "op2", c_uint8 )]



def MakeRequest( cmd, op1, op2 ):
	command = CustomProtocol( cmd, op1, op2 )
	return command


def PrintRequest( request ):


request = MakeRequest( "HandShake", 65, 48 )

print request