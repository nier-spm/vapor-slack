//
//  File.swift
//  
//
//  Created by nier on 2021/7/15.
//

import Foundation

public struct SlackMultiConversationsSelectElement: SlackMultiSelectElement, SlackMessageBlockElement, Codable {
    
    public var type: SlackBlockElementType = .multiSelect(.conversations)
    public var placeholder: SlackTextObject
    public var actionID: String
    public var initialConversations: [String]?
    public var defaultToCurrentConversation: Bool?
    public var confirm: SlackConfirmObject?
    public var maxSelectedItems: Int?
    public var filter: SlackFilterObject?
    
    public init(_ actionID: String = UUID().uuidString, placeholder: String, initialConversations: [String]? = nil, defaultToCurrentConversation: Bool? = nil, confirm: SlackConfirmObject? = nil, maxSelectedItems: Int? = nil, filter: SlackFilterObject? = nil) {
        self.placeholder = SlackTextObject(plaintext: placeholder)
        self.actionID = actionID
        self.initialConversations = initialConversations
        self.defaultToCurrentConversation = defaultToCurrentConversation
        self.confirm = confirm
        self.maxSelectedItems = maxSelectedItems
        self.filter = filter
    }
    
    enum CodingKeys: String, CodingKey {
        case type
        case placeholder
        case actionID = "action_id"
        case initialConversations = "initial_conversations"
        case defaultToCurrentConversation = "default_to_current_conversation"
        case confirm
        case maxSelectedItems = "max_selected_items"
        case filter
    }
}
