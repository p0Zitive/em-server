import sys
import binascii

from Protocol import CustomProtocol


DEBUG = 1


def MakeRequest( cmd, op1, op2 ):
	command = CustomProtocol( cmd, op1, op2 )
	return command


def PrintRequest( request ):
	print 'Binary data: 0x%s' % binascii.hexlify( request._packedData )


def main( arg = [] ):
	request = MakeRequest( "HSH\0", 65, 48 )
	PrintRequest( request )


if __name__== '__main__':
    main( arg = sys.argv[1:] )