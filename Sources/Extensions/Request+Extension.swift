import Vapor

extension Request {
    
    public var slack: Slack {
        return Slack(self)
    }
}
