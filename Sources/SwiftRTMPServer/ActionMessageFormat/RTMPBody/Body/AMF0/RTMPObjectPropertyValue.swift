import SwiftyBit
import Foundation

struct RTMPObjectPropertyValue: RTMPDataCreateConvertible {
    
    private static let propertyNameLengthByteSize: Int = 2
    
    var name: String
    var value: RTMPAMF0ObjectConvertible
    
    static func create(data: inout Data) -> RTMPObjectPropertyValue {
        
        let propertyName = getPropertyName(data: &data)
        let propertyValue = getPropertyValue(data: &data)
        
        
        return RTMPObjectPropertyValue(
            name: propertyName,
            value: propertyValue
        )
    }
    
    private static func getPropertyName(data: inout Data) -> String {

        //nameの長さ取得
        let propertyNameLengthData = data
            .removeByteFromFirst(to: propertyNameLengthByteSize)
        
        let propertyNameLength = propertyNameLengthData.uint16
        
        //nameの値取得
        let propertyNameData = data
            .removeByteFromFirst(to: Int(propertyNameLength))
        let propertyName = String(data: propertyNameData, encoding: .utf8)
        
        return propertyName ?? ""
    }
    
    private static func getPropertyValue(data: inout Data) -> RTMPAMF0ObjectConvertible {
        
        //先頭1byteを取り出してAMF0Markerに応じてパースする
        guard let markerByte = data.first else {
            fatalError("property data is empty")
        }
        
        guard let marker = AMF0Marker(rawValue: markerByte) else {
            fatalError("invalid marker format. value: \(markerByte)")
        }
        
        return marker.createValue(data: &data)
    }
    
    func toData() -> Data {
        
        guard let nameData = name.data(using: .utf8) else {
            fatalError("name cannot encode")
        }
        
        var data = Data()
        
        //nemelengthを2バイト固定長にする
        let nameLength = UInt16(name.count)
        let nameLengthByte = nameLength.data
        data.append(nameLengthByte)
        data.append(nameData)
        
        //valueのデータ作成
        let valueData = value.toData()
        data.append(valueData)
        
        return data
    }
}
