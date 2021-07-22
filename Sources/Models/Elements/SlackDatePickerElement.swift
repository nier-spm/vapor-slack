//
//  File.swift
//  
//
//  Created by nier on 2021/7/14.
//

import Foundation

public struct SlackDatePickerElement: SlackBlockElement, SlackMessageBlockElement, Codable {
    
    public var type: SlackBlockElementType = .datepicker
    public var actionID: String
    public var placeholder: SlackTextObject?
    public var initialDate: String?
    public var confirm: SlackConfirmObject?
    
    public init(_ actionID: String, placeholder: String? = nil, initialDate: String? = nil, confirm: SlackConfirmObject? = nil) {
        self.actionID = actionID
        self.placeholder = placeholder != nil ? SlackTextObject(plaintext: placeholder!) : nil
        self.initialDate = initialDate
        self.confirm = confirm
    }
    
    enum CodingKeys: String, CodingKey {
        case type
        case actionID = "action_id"
        case placeholder
        case initialDate = "initial_date"
        case confirm
    }
}
