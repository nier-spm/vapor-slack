//
//  File.swift
//  
//
//  Created by nier on 2021/7/13.
//

import Foundation

public struct SlackButtonElement: SlackBlockElement, SlackMessageBlockElement, Codable {
    
    public var type: SlackBlockElementType = .button
    public var text: SlackTextObject
    public var actionID: String
    public var url: String?
    public var value: String?
    public var style: SlackBlockButtonElementStyle?
    public var confirm: SlackConfirmObject?
    
    public init(_ actionID: String = UUID().uuidString, text: String, url: String? = nil, value: String? = nil, style: SlackBlockButtonElementStyle? = nil, confirm: SlackConfirmObject? = nil) {
        self.actionID = actionID
        self.text = SlackTextObject(plaintext: text)
        self.url = url
        self.value = value
        self.style = style
        self.confirm = confirm
    }
    
    enum CodingKeys: String, CodingKey {
        case type
        case text
        case actionID = "action_id"
        case url
        case value
        case style
        case confirm
    }
}
