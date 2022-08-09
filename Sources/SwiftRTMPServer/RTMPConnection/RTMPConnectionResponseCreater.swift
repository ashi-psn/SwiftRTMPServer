import Foundation
import SwiftyBit

final class RTMPConnectionResponseCreater {
    
    static var tempData = Data()
    
    static func create(data: inout Data, completation: ((RTMPStream) -> Void)) {
        
        var mutableData = tempData
        tempData = Data()
        mutableData.append(data)
        
        while mutableData.count > 0 {
            //複数チャンクがまとめて送られるため、lengthで分割する
            let header = RTMPHeader.create(data: &mutableData)
            
            var headerLength = header.messageHeader.messageLength
            
            //128バイト以上の場合、c3,c4が追加されるため、読み込みを1byte追加する
            if
                let length = headerLength,
                length > 128
            {
                headerLength? += 1
            }
            
            //パケットの途中で送られることがあるため、キャッシュさせて次回受信時に結合させる
//            if
//                let length = headerLength,
//                mutableData.count < length {
//                tempData = mutableData
//                break
//            }
//
//            var bodyData = Data()
//            bodyData = mutableData.removeByteFromFirst(to: mutableData.count)
            //bodyをパースしてもパケットが余る場合
//            var bodyData = Data()
//
//            if let length = headerLength {
//                bodyData = mutableData.removeByteFromFirst(to: Int(length))
//                tempData = mutableData
//            } else {
//                bodyData = mutableData.removeByteFromFirst(to: mutableData.count)
//            }
            
            if let messageHeader = header.messageHeader.messageType {
                
                switch messageHeader {
                case .setChankSize:
                    createDataUseSetChankSize(
                        header: header,
                        data: &mutableData,
                        completation: completation
                    )
                case .windowAcknowledgement:
                    createDataUseWindowAcknowledgement(
                        header: header,
                        data: &mutableData,
                        completation: completation
                    )
                case .setPeerBandWidth:
                    createDataUseSetPeerBandWidth(
                        header: header,
                        data: &mutableData,
                        completation: completation
                    )
                case .amf0command:
                    createDataUseAMF0Format(
                        header: header,
                        data: &mutableData,
                        completation: completation
                    )
                    
                case .amf0data:
                    createDataUseAMF0Data(
                        header: header,
                        data: &mutableData,
                        completation: completation
                    )
                    
                case .abort:
                    print()
                case .acknowledgemtn:
                    print()
                }
                
            } else {
                createDataUseAMF0Format(
                    header: header,
                    data: &mutableData,
                    completation: completation
                )
            }
        }
    }
    
    private static func createDataUseAMF0Format(
        header: RTMPHeader,
        data: inout Data,
        completation: ((RTMPStream) -> Void)
    ) {
        if var length = header.messageHeader.messageLength {
            //128バイト以上の場合、c3、c4が含まれるため1byte足す
            if length > 128 {
                length += 1
            }
            var separatedBodyData = data.removeByteFromFirst(to: Int(length))
            let body = RTMPBody.create(data: &separatedBodyData)
            let stream = RTMPStream(
                header: header,
                body: body
            )
            completation(stream)
            
        } else {
            let body = RTMPBody.create(data: &data)
            let stream = RTMPStream(
                header: header,
                body: body
            )
            completation(stream)
        }
    }
    
    private static func createDataUseAMF0Data(
        header: RTMPHeader,
        data: inout Data,
        completation: ((RTMPStream) -> Void)
    ) {
        if var length = header.messageHeader.messageLength {
            //128バイト以上の場合、c3、c4が含まれるため1byte足す
            if length > 128 {
                length += 1
            }
            var separatedBodyData = data.removeByteFromFirst(to: Int(length))
            let body = RTMPBody.create(data: &separatedBodyData)
            let stream = RTMPStream(
                header: header,
                body: body
            )
            completation(stream)
            
        } else {
            let body = RTMPBody.create(data: &data)
            let stream = RTMPStream(
                header: header,
                body: body
            )
            completation(stream)
        }
    }
    
    private static func createDataUseSetChankSize(
        header: RTMPHeader,
        data: inout Data,
        completation: ((RTMPStream) -> Void)) {
            
            let setChankSize = RTMPSetChankSizeValue.create(data: &data)
            let body = RTMPBody(body: [setChankSize])
            let stream = RTMPStream(header: header, body: body)
            completation(stream)
    }
    
    private static func createDataUseWindowAcknowledgement(
        header: RTMPHeader,
        data: inout Data,
        completation: ((RTMPStream) -> Void)) {
            
            let windowAcknowledgement = RTMPWindowAcknowledgementValue.create(data: &data)
            let body = RTMPBody(body: [windowAcknowledgement])
            let stream = RTMPStream(header: header, body: body)
            completation(stream)
    }
    
    private static func createDataUseSetPeerBandWidth(
        header: RTMPHeader,
        data: inout Data,
        completation: ((RTMPStream) -> Void)) {
            
            let setPeerBandWidth = RTMPSetPeerBandWidthValue.create(data: &data)
            let body = RTMPBody(body: [setPeerBandWidth])
            let stream = RTMPStream(header: header, body: body)
            completation(stream)
    }
}
