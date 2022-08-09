import Foundation

enum RTMPMessageType: UInt8 {
    case setChankSize = 0x01
    case abort = 0x02
    case acknowledgemtn = 0x03
    case windowAcknowledgement = 0x05
    case setPeerBandWidth = 0x06
    case amf0data = 0x12
    case amf0command = 0x14
}

enum UserControlMessageEventType: UInt16 {
    case streamBegin = 0
    case streamEOF = 1
    case streamDry = 2
    case setBufferLength = 3
    case streamsRecorded = 4
    case pingRequest = 6
    case pingResponse = 7
}
