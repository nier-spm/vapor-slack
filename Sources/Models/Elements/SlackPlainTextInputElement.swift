//
//  File.swift
//  
//
//  Created by nier on 2021/7/14.
//

import Foundation

public struct SlackPlainTextInputElement: SlackBlockElement, SlackMessageBlockElement, Codable {
    
    public var type: SlackBlockElementType = .plainTextInput
    public var actionID: String
    public var placeholder: SlackTextObject?
    public var initialValue: String?
    public var multiline: Bool?
    public var minLength: Int?
    public var maxLength: Int?
    public var dispatchActionConfig: [String]? // dispatch configuration object
    
    public init(_ actionID: String = UUID().uuidString, placeholder: String? = nil, initialValue: String? = nil, multiline: Bool?, minLength: Int? = nil, maxLength: Int? = nil, dispatchActionConfig: [String]? = nil) {
        self.actionID = actionID
        self.placeholder = placeholder != nil ? SlackTextObject(plaintext: placeholder!) : nil
        self.initialValue = initialValue
        self.multiline = multiline
        self.minLength = minLength
        self.maxLength = maxLength
        self.dispatchActionConfig = dispatchActionConfig
    }
    
    enum CodingKeys: String, CodingKey {
        case type
        case actionID = "action_id"
        case placeholder
        case initialValue = "initial_value"
        case multiline
        case minLength = "min_length"
        case maxLength = "max_length"
        case dispatchActionConfig = "dispatch_action_config"
    }
}
