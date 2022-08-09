import Foundation
import SwiftyBit

struct RTMPBody: RTMPDataCreateConvertible {
    
    let body: [RTMPDataCreateConvertible]
    
    static func create(data: inout Data) -> RTMPBody {
        
        var body: [RTMPAMF0ObjectConvertible] = []
        
        //128byteでchankが区切られる、c3,c4がマーカーとなり結合して送られるため、マーカーを削除する
        if data.count > 128 {
            let isContinue = data.bytes[128] == 0xc3 || data.bytes[128] == 0xc4
            if isContinue {
                var mutableData = data
                
                let currentBodyData = Array(
                    mutableData.bytes[0..<128]
                ).data
                
                mutableData = Array(
                    mutableData.bytes[129..<data.count]
                ).data
                
                var rtmpBodyData = Data()
                rtmpBodyData.append(currentBodyData)
                rtmpBodyData.append(mutableData)
                data = rtmpBodyData
            }
        }
        
        
        
        //データパース
        while data.count > 0 {
            
            guard let markerByte = data.first else {
                fatalError("marker byte is empty")
            }
            
            guard let marker = AMF0Marker(rawValue: markerByte) else {
                fatalError("invalid marker format. value: \(markerByte)")
            }
            
            let bodyData = marker.createValue(data: &data)
            body.append(bodyData)
        }
        
        return RTMPBody(body: body)
    }
    
    func toData() -> Data {
        var data = Data()
        body.forEach {
            data.append($0.toData())
        }
        
        var resultDataByte: [UInt8] = []
        for (count, byte) in data.bytes.enumerated() {
            //128byteごとにチャンクの区切りとしてc3を入れる
            if count == (128 - 1) {
                let chankSeparateFlug: UInt8 = 0xc3
                resultDataByte.append(chankSeparateFlug)
            }
            resultDataByte.append(byte)
        }
        return resultDataByte.data
    }
}
