import Vapor

public struct SlackConfigutaion {
    
    private let token: String

    /**
     Initializer of Slack configuration
     
     - Parameters:
        - token: Slack bot user OAuth token
     
     # Reference
     
     [Access tokens | Slack](https://api.slack.com/authentication/token-types)
     */
    public init(_ token: String = "") {
        self.token = token
    }
}

// MARK: - Slack Initializer
extension SlackConfigutaion {
    
    
    // MARK: Init by enviornment key
    /**
     Initializer of Line.
     
     - Parameters:
        - key: environment key of bot token
     */
    public static func enviornment(_ key: String) throws -> SlackConfigutaion {
        guard let token = Environment.get(key) else {
            throw SlackError(.environmentNotFound(key))
        }
        
        return self.init(token)
    }
}

// MARK: -
extension SlackConfigutaion {
    
    // MARK: Request header
    /**
     Http headers with Slack bot token.
     */
    var header: HTTPHeaders {
        var headers: HTTPHeaders = HTTPHeaders()
        
        headers.add(name: .authorization, value: "Bearer \(self.token)")
        
        return headers
    }
}
