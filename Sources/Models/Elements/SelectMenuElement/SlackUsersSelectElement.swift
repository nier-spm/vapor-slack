//
//  File.swift
//  
//
//  Created by nier on 2021/7/15.
//

import Foundation

public struct SlackUsersSelectElement: SlackSelectElement, SlackMessageBlockElement, Codable {
    
    public var type: SlackBlockElementType = .select(.users)
    public var placeholder: SlackTextObject
    public var actionID: String
    public var initialUser: String?
    public var confirm: SlackConfirmObject?
    
    public init(_ actionID: String = UUID().uuidString, placeholder: String, initialUser: String? = nil, confirm: SlackConfirmObject? = nil) {
        self.placeholder = SlackTextObject(plaintext: placeholder)
        self.actionID = actionID
        self.initialUser = initialUser
        self.confirm = confirm
    }
    
    enum CodingKeys: String, CodingKey {
        case type
        case placeholder
        case actionID = "action_id"
        case initialUser = "initial_user"
        case confirm
    }
}
