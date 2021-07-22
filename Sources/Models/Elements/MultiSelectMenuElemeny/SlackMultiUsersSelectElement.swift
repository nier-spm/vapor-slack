//
//  File.swift
//  
//
//  Created by nier on 2021/7/15.
//

import Foundation

public struct SlackMultiUsersSelectElement: SlackMultiSelectElement, SlackMessageBlockElement, Codable {
    
    public var type: SlackBlockElementType = .select(.users)
    public var placeholder: SlackTextObject
    public var actionID: String
    public var initialUsers: [String]?
    public var confirm: SlackConfirmObject?
    public var maxSelectedItems: Int?
    
    public init(_ actionID: String = UUID().uuidString, placeholder: String, initialUsers: [String]? = nil, confirm: SlackConfirmObject? = nil, maxSelectedItems: Int? = nil) {
        self.placeholder = SlackTextObject(plaintext: placeholder)
        self.actionID = actionID
        self.initialUsers = initialUsers
        self.confirm = confirm
        self.maxSelectedItems = maxSelectedItems
    }
    
    enum CodingKeys: String, CodingKey {
        case type
        case placeholder
        case actionID = "action_id"
        case initialUsers = "initial_users"
        case confirm
        case maxSelectedItems = "max_selected_items"
    }
}
