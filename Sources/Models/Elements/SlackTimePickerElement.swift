//
//  File.swift
//  
//
//  Created by nier on 2021/7/15.
//

import Foundation

public struct SlackTimePickerElement: SlackBlockElement, SlackMessageBlockElement, Codable {
    
    public var type: SlackBlockElementType = .timepicker
    public var actionID: String
    public var placeholder: SlackTextObject?
    public var initialTime: String?
    public var confirm: SlackConfirmObject?
    
    public init(_ actionID: String = UUID().uuidString, placeholder: String? = nil, initialTime: String? = nil, confirm: SlackConfirmObject? = nil) {
        self.actionID = actionID
        self.placeholder = placeholder != nil ? SlackTextObject(plaintext: placeholder!) : nil
        self.initialTime = initialTime
        self.confirm = confirm
    }
    
    enum CodingKeys: String, CodingKey {
        case type
        case actionID = "action_id"
        case placeholder
        case initialTime = "initial_time"
        case confirm
    }
}
