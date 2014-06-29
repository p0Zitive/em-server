require 'bindata'
 
class CustomProtocol < BinData::Record
    endian  :little
    stringz :command_word
    uint8   :op1
    uint8   :op2
end