import Vapor

extension Application {
    
    private static var _slack: SlackConfigutaion?
    
    /**
     Configuration of Slack.
     */
    public var slack: SlackConfigutaion {
        get {
            return Application._slack ?? SlackConfigutaion()
        }
        set(newValue) {
            Application._slack = newValue
        }
    }
}
