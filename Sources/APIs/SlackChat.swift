import Foundation

public enum SlackChat: String {
    case postMessage
}

extension SlackChat: SlackAPI {
    
    public var category: String {
        return "chat"
    }

    public var api: String {
        return "\(category).\(self.rawValue)"
    }
}
