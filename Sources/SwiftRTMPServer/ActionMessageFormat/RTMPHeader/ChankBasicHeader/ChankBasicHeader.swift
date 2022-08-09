import Foundation

struct ChankBasicHeader: RTMPDataCreateConvertible {
    
    var basicHeaderType: ChankBasicHeaderType
    
    /// chank format version 2bit
    var fmt: FormatType
    
    /// chank stream id
    /// 6bit or 2byte
    var chankStreamId: UInt16
    
    static func create(data: inout Data) -> ChankBasicHeader {
        
        //fmtの値からmessage headerのサイズを取得する
        let fmtType = getFMTType(data: data)
        
        //basicヘッダーのサイズとmessageヘッダーのサイズをbasic header typeにして取り出す
        let chankStreamType =
            getChankBasicHeaderByteType(data: data)
        let basicHeaderByteSize = chankStreamType.rawValue
        var basicHeaderData = data.removeByteFromFirst(to: basicHeaderByteSize)
        
        let chankStreamId: UInt16 = {
            switch chankStreamType {
            case .one:
                return getFMTType1ChankStreamId(data: &basicHeaderData)
            case .two:
                return getFMTType2ChankStreamId(data: &basicHeaderData)
            case .three:
                return getFMTType3ChankStreamId(data: &basicHeaderData)
            }
        }()
        
        return ChankBasicHeader(
            basicHeaderType: chankStreamType,
            fmt: fmtType,
            chankStreamId: chankStreamId)
    }
    
    private static func getFMTType(data: Data) -> FormatType {
        let bytes = data.bytes
        guard let firstByte = bytes.first else {
            fatalError("bytes is empty")
        }

        //先頭2bitを後ろに合わせて右に6bitシフトする
        let bitByte = firstByte >> 6

        guard let type = FormatType(rawValue: bitByte) else {
            fatalError("unsupported fmt version. version is \(bitByte)")
        }
        return type
    }
    
    private static func getChankBasicHeaderByteType(data: Data) -> ChankBasicHeaderType {
        //1byteの場合、3bitから8bitまでがCSID
        //2byteの場合、3bitから8bitが0になり、2byte目がCSID
        //3byteの場合、3bitから8bitが1になり、2byteから3byteがCSID

        guard let firstByte = data.first else {
            fatalError("data is empty")
        }

        //1byte目の3bitから8bitを取り出して、0か1かを調べる
        //右に2シフト、左に2シフトさせてfmt部分を0にする
        var checkByte = firstByte
        checkByte = checkByte << 2
        checkByte = checkByte >> 2
        // basic headerのバイト数は
        //chank stream idの4bitが全て1の場合3バイト、
        //それ以下でかつ1以上であれば1バイト、
        //0であれば3バイトとなる
        if checkByte == 0b00111111 {
            return .three
        } else if checkByte > 0 {
            return .one
        } else {
            return .two
        }
    }
    
    func toData() -> Data {
        
        switch basicHeaderType {
        case .one:
            return toDataBasicHeaderType1()
        case .two:
            return toDataBasicHeaderType2()
        case .three:
            return toDataBasicHeaderType3()
        }
    }
}


// MARK: - ChankBasicHeader + chankStreamId
extension ChankBasicHeader {
    
    private static func getFMTType1ChankStreamId(data: inout Data) -> UInt16 {
        
        guard let firstByte = data.first else {
            fatalError("data is empty")
        }
        
        //3bitから8bit目がchank stream id
        //先頭2bitを0にした後、右シフトで元の位置に戻してchankStreamの値を取り出す
        var chankStreamIdByte = firstByte << 2
        chankStreamIdByte = chankStreamIdByte >> 2
        return UInt16(chankStreamIdByte)
    }
    
    private static func getFMTType2ChankStreamId(data: inout Data) -> UInt16 {
        
        //2byte目がchankstreamidになる
        //fmtのみの1byte目を削除
        data.removeFirst()
        //2byte目にchankStreamIdが入っているため取り出す
        let chankStreamIdByte = data.removeFirst()
        
        return UInt16(chankStreamIdByte)
    }
    
    private static func getFMTType3ChankStreamId(data: inout Data) -> UInt16 {
        
        guard data.count == 3 else {
            fatalError("invalid Chank2 format")
        }
        
        //後ろ2byte取り出し
        data.removeFirst()
        
        //1度Dataをバイト配列にしてデータを作り直さないとuint16で受け取ることができない
        let chankStreamIdBytes = data.bytes
        let chankStreamIdData = Data(bytes: chankStreamIdBytes, count: chankStreamIdBytes.count)
        return chankStreamIdData.uint16
    }
}

// MARK: ChankBasicHeader + toData()
extension ChankBasicHeader {
    
    
    private func toDataBasicHeaderType1() -> Data {
        
        //先頭2bitにfmtを持っていく
        var fmtMask = fmt.rawValue
        fmtMask = fmtMask << 6
        
        let csId = UInt8(chankStreamId)
        //先頭2bitを0で埋める
        var csIdMask = csId
        csIdMask = csIdMask << 2
        csIdMask =  csIdMask >> 2
        
        //bitorで結合する
        let chank = fmtMask | csIdMask
        
        return chank.data
    }
    
    private func toDataBasicHeaderType2() -> Data {
        
        var data = Data()
        
        //先頭2bitにfmtを持っていく
        var fmtMask = fmt.rawValue
        fmtMask = fmtMask << 6
        data.append(fmtMask.data)
        
        let csId = UInt8(chankStreamId)
        data.append(csId.data)
        
        
        return data
    }
    
    private func toDataBasicHeaderType3() -> Data {
        
        var data = Data()
        
        //先頭2bitにfmtを持っていく
        var fmtMask = fmt.rawValue
        fmtMask = fmtMask << 6
        
        //3バイト用フラグ
        let flag: UInt8 = 0b00111111
        
        //bitorで結合する
        let firstByte = fmtMask | flag
        data.append(firstByte)
        
        
        data.append(chankStreamId.data)
        
        return data
    }
}
