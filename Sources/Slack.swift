import Vapor

public struct Slack {
    
    private let request: Request
    private let baseURL: String = "https://slack.com/api/"
    
    init(_ request: Request) {
        self.request = request
    }
}

extension Slack {
    
    public func message(_ payload: SlackMessagePayload) -> EventLoopFuture<ClientResponse> {
        let api: String = self.baseURL + SlackChat.postMessage.api
        let headers: HTTPHeaders = self.request.application.slack.header
        
        return self.request.client.post(URI(string: api), headers: headers) { request in
            if self.request.application.environment != .production {
                let content = try JSONEncoder().encode(payload)
                print("[ Slack ] \(content)")
            }
            
            try request.content.encode(payload)
        }
    }
}
