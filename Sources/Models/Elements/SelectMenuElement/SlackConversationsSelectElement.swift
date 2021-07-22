//
//  File.swift
//  
//
//  Created by nier on 2021/7/15.
//

import Foundation

public struct SlackConversationsSelectElement: SlackSelectElement, SlackMessageBlockElement, Codable {
    
    public var type: SlackBlockElementType = .select(.conversations)
    public var placeholder: SlackTextObject
    public var actionID: String
    public var initialConversation: String?
    public var defaultToCurrentConversation: Bool?
    public var confirm: SlackConfirmObject?
    public var responseURLEnabled: Bool?
    public var filter: SlackFilterObject?
    
    public init(_ actionID: String = UUID().uuidString, placeholder: String, initialConversation: String? = nil, defaultToCurrentConversation: Bool? = nil, confirm: SlackConfirmObject? = nil, responseURLEnabled: Bool? = nil, filter: SlackFilterObject? = nil) {
        self.placeholder = SlackTextObject(plaintext: placeholder)
        self.actionID = actionID
        self.initialConversation = initialConversation
        self.defaultToCurrentConversation = defaultToCurrentConversation
        self.confirm = confirm
        self.responseURLEnabled = responseURLEnabled
        self.filter = filter
    }
    
    enum CodingKeys: String, CodingKey {
        case type
        case placeholder
        case actionID = "action_id"
        case initialConversation = "initial_conversation"
        case defaultToCurrentConversation = "default_to_current_conversation"
        case confirm
        case responseURLEnabled
        case filter
    }
}
