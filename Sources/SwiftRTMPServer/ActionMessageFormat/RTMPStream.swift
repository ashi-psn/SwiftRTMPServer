import Foundation

struct RTMPStream: RTMPDataCreateConvertible {
    
    let header: RTMPHeader
    let body: RTMPBody
    
    static func create(data: inout Data) -> RTMPStream {
        let header = RTMPHeader.create(data: &data)
        
        let body = RTMPBody.create(data: &data)
        
        return RTMPStream(
            header: header,
            body: body
        )
    }
    
    func toData() -> Data {
        var data = Data()
        data.append(header.toData())
        data.append(body.toData())
        return data
    }
}
