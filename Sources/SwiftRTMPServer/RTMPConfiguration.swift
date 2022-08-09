import Network

public struct RTMPConfiguration {
    public var host: String = "localhost"
    public var port: NWEndpoint.Port = NWEndpoint.Port(integerLiteral: 1935)
    public var postInt: Int {
        Int(port.rawValue)
    }
}
