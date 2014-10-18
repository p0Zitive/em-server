import array
import struct
import ctypes


class CustomProtocol( object ):
	def __init__( self, cmd, op1, op2 ):
		values = ( cmd, op1, op2 )
		packetStruct = struct.Struct( '4s B B' )

		self._packedData = array.array( 'c', '\0' * packetStruct.size )

		packetStruct.pack_into( self._packedData, 0, *values )