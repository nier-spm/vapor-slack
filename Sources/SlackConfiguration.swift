import Vapor

public struct SlackConfigutaion {
    
    private let token: String

    public init(_ token: String = "") {
        self.token = token
    }
}

extension SlackConfigutaion {
    
    public static func enviornment(_ key: String) throws -> SlackConfigutaion {
        guard let token = Environment.get(key) else {
            throw SlackError(.environmentNotFound(key))
        }
        
        return self.init(token)
    }
}

extension SlackConfigutaion {
    
    var header: HTTPHeaders {
        var headers: HTTPHeaders = HTTPHeaders()
        
        headers.add(name: .authorization, value: "Bearer \(self.token)")
        
        return headers
    }
}
