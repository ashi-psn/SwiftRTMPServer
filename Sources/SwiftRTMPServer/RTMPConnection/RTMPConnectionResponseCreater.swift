import Foundation
import SwiftyBit

final class RTMPConnectionResponseCreater {
    
    static var tempData = Data()
    
    static func create(data: inout Data, completation: ((RTMPStream) -> Void)) {
        
        var mutableData = tempData
        tempData = Data()
        mutableData.append(data)
        
        let header = RTMPHeader.create(data: &mutableData)
        
        //バイト数が足りない場合は値を保持して次回リクエスト受信時に結合する
        if
            let length = header.messageHeader.messageLength,
            length > mutableData.count {
            tempData = mutableData.removeByteFromFirst(to: mutableData.count)
            return
        }
        
        var bodyData = Data()
        
        switch header.basicHeader.fmt {
        case .zero, .one, .two:
            if var bodyLength = header.messageHeader.messageLength {
                
                //amf0commandの場合、128バイトより大きければc3などでチャンク区切りが含まれる
                if header.messageHeader.messageType == .amf0command && bodyLength > 128 {
                    bodyLength += 1
                }
                
                bodyData = mutableData.removeByteFromFirst(to: Int(bodyLength))
            } else {
                bodyData = mutableData.removeByteFromFirst(to: mutableData.count)
            }

            if let messageHeader = header.messageHeader.messageType {
                
                switch messageHeader {
                case .setChankSize:
                    createDataUseSetChankSize(
                        header: header,
                        data: &bodyData,
                        completation: completation
                    )
                case .windowAcknowledgement:
                    createDataUseWindowAcknowledgement(
                        header: header,
                        data: &bodyData,
                        completation: completation
                    )
                case .setPeerBandWidth:
                    createDataUseSetPeerBandWidth(
                        header: header,
                        data: &bodyData,
                        completation: completation
                    )
                case .amf0command:
                    createDataUseAMF0Format(
                        header: header,
                        data: &bodyData,
                        completation: completation
                    )
                    
                case .amf0data:
                    createDataUseAMF0Data(
                        header: header,
                        data: &bodyData,
                        completation: completation
                    )
                    
                case .videoData:
                    createDataUseVideoData(
                        header: header,
                        data: &bodyData,
                        completation: completation
                    )
                    
                case .abort:
                    createDataUseAbortData(
                        header: header,
                        data: &bodyData,
                        completation: completation
                    )
                case .acknowledgemtn:
                    print()
                
                }
                
            } else {
                createDataUseAMF0Format(
                    header: header,
                    data: &bodyData,
                    completation: completation
                )
            }
            
            //パケットが残っている場合は再帰させて処理する
            if mutableData.count > 0 {
                create(data: &mutableData, completation: completation)
            }
            
        case .three:
            createDataUseAMF0Format(
                header: header,
                data: &mutableData,
                completation: completation
            )
        }
    }
    
    private static func createDataUseAMF0Format(
        header: RTMPHeader,
        data: inout Data,
        completation: ((RTMPStream) -> Void)
    ) {
        let body = RTMPBody.create(data: &data)
        let stream = RTMPStream(
            header: header,
            body: body
        )
        completation(stream)
    }
    
    private static func createDataUseAMF0Data(
        header: RTMPHeader,
        data: inout Data,
        completation: ((RTMPStream) -> Void)
    ) {
        let body = RTMPBody.create(data: &data)
        let stream = RTMPStream(
            header: header,
            body: body
        )
        completation(stream)
    }
    
    private static func createDataUseVideoData(
        header: RTMPHeader,
        data: inout Data,
        completation: ((RTMPStream) -> Void)
    ) {
        
        let videoData = RTMPVideoDataValue.create(data: &data)
        let body = RTMPBody(body: [videoData])
        let stream = RTMPStream(
            header: header,
            body: body
        )
        completation(stream)
    }
    
    private static func createDataUseAbortData(
        header: RTMPHeader,
        data: inout Data,
        completation: ((RTMPStream) -> Void)) {
            let body = RTMPBody(body: [])
            let stream = RTMPStream(header: header, body: body)
            completation(stream)
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
