import Vapor

public struct Slack {
    
    private let request: Request
    private let baseURL: String = "https://slack.com/api/"
    
    /**
     Initializer of Slack.
     
    - Parameters:
        - request: client request
     */
    init(_ request: Request) {
        self.request = request
    }
}

// MARK: - 
extension Slack {
    
    // MARK: message api by Slack bot
    /**
     Send message to specify channel through Slack bot.
     
     - Parameters:
        - payload: Slack message content
     
     # Reference
     
     [Post Message | Slack Web API](https://api.slack.com/methods/chat.postMessage)
     */
    public func message(_ payload: SlackMessagePayload) -> EventLoopFuture<ClientResponse> {
        let api: String = self.baseURL + SlackChat.postMessage.api
        let headers: HTTPHeaders = self.request.application.slack.header
        
        return self.request.client.post(URI(string: api), headers: headers) { request in
            let body = try JSONEncoder().encode(payload)
            
            print("[ Slack.payload ] \(String(decoding: body, as: UTF8.self))")
            
            try request.content.encode(payload)
        }.flatMapThrowing { response in
            print("[ Slack.response ] \(response.status.code) \(response.status)")
            
            if let body = response.body {
                let res = Data(body.readableBytesView)
                
                print("[ Slack.response ] \(String(decoding: res, as: UTF8.self))")
            }
            
            return response
        }
    }
}
