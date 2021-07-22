//
//  File.swift
//  
//
//  Created by nier on 2021/7/15.
//

import Foundation

public struct SlackExternalSelectElement: SlackSelectElement, SlackMessageBlockElement {
    
    public var type: SlackBlockElementType = .select(.external)
    public var placeholder: SlackTextObject
    public var actionID: String
    public var initialOption: SlackBlockObject?
    public var minQueryLength: Int?
    public var confirm: SlackConfirmObject?
    
    public init(_ actionID: String = UUID().uuidString, placeholder: String, initialOption: SlackBlockObject? = nil, minQueryLength: Int? = nil, confirm: SlackConfirmObject? = nil) {
        self.placeholder = SlackTextObject(plaintext: placeholder)
        self.actionID = actionID
        self.initialOption = initialOption
        self.minQueryLength = minQueryLength
        self.confirm = confirm
    }
}

// MARK: - Codable
extension SlackExternalSelectElement: Codable {
    
    enum CodingKeys: String, CodingKey {
        case type
        case placeholder
        case actionID = "action_id"
        case initialOption = "initial_option"
        case minQueryLength = "min_query_length"
        case confirm
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.type = try container.decode(SlackBlockElementType.self, forKey: .type)
        self.placeholder = try container.decode(SlackTextObject.self, forKey: .placeholder)
        self.actionID = try container.decode(String.self, forKey: .actionID)
        
        if let option = try container.decodeIfPresent(SlackOptionObject.self, forKey: .initialOption) {
            self.initialOption = option
        } else if let optionGroup = try container.decodeIfPresent(SlackOptionGroupObject.self, forKey: .initialOption) {
            self.initialOption = optionGroup
        }
        
        self.minQueryLength = try container.decodeIfPresent(Int.self, forKey: .minQueryLength)
        self.confirm = try container.decodeIfPresent(SlackConfirmObject.self, forKey: .confirm)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.type, forKey: .type)
        try container.encode(self.placeholder, forKey: .placeholder)
        try container.encode(self.actionID, forKey: .actionID)
        
        if let option = self.initialOption as? SlackOptionObject {
            try container.encode(option, forKey: .initialOption)
        } else if let optionGroup = self.initialOption as? SlackOptionGroupObject {
            try container.encode(optionGroup, forKey: .initialOption)
        }
        
        try container.encodeIfPresent(self.minQueryLength, forKey: .minQueryLength)
        try container.encodeIfPresent(self.confirm, forKey: .confirm)
    }
}
