import NIO
import NIOCore

open class RTMPServer {
    
    public enum ConnectionState {
        case unconnected
        case sendS0
        case sendS1
        case sendS2
        case connected
        case connectionEstablish
    }
    
    private let eventloopGroup = MultiThreadedEventLoopGroup(numberOfThreads: System.coreCount)
    
    let configuration: RTMPConfiguration
    
    var serverBootStrap: ServerBootstrap {
        return ServerBootstrap(group: eventloopGroup)
            .serverChannelOption(ChannelOptions.backlog, value: 256)
            .serverChannelOption(ChannelOptions.socket(SocketOptionLevel(SOL_SOCKET), SO_REUSEADDR), value: 1)
            .childChannelInitializer { channel in
                channel.pipeline.addHandler(RTMPChannelHandler())
            }
    }
    
    init(configuration: RTMPConfiguration) {
        self.configuration = configuration
    }
    
    deinit {
        try! eventloopGroup.syncShutdownGracefully()
    }
    
    open func listhen() {
        
        let startMessage =
"""
-------------------------
| server listen on \(configuration.port) |
-------------------------
"""
        
        do {
            let channel = try serverBootStrap
                .bind(host: configuration.host, port: configuration.postInt)
                .wait()
            
            print(startMessage)
            
            try channel.closeFuture.wait()
        } catch {
            fatalError("failed to start server: \(error)")
        }
    }
}
