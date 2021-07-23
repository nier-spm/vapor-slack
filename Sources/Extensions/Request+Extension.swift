import Vapor

extension Request {
    
    /**
     Service provider of Slack.
     */
    public var slack: Slack {
        return Slack(self)
    }
}
