//
//  File.swift
//  
//
//  Created by nier on 2021/7/15.
//

import Foundation

public struct SlackStaticSelectElement: SlackSelectElement, SlackMessageBlockElement {
    
    public var type: SlackBlockElementType = .select(.static)
    public var placeholder: SlackTextObject
    public var actionID: String
    public var options: [SlackOptionObject]
    public var optionGroups: [SlackOptionGroupObject]?
    public var initialOption: SlackBlockObject?
    public var confirm: SlackConfirmObject?
    
    public init(_ actionID: String = UUID().uuidString, placeholder: String, options: [SlackOptionObject] = [], optionGroups: [SlackOptionGroupObject]? = nil, initialOption: SlackBlockObject? = nil, confirm: SlackConfirmObject? = nil) {
        self.placeholder = SlackTextObject(plaintext: placeholder)
        self.actionID = actionID
        self.options = options
        self.optionGroups = optionGroups
        self.initialOption = initialOption
        self.confirm = confirm
    }
}

// MARK: - Codable
extension SlackStaticSelectElement: Codable {
    
    enum CodingKeys: String, CodingKey {
        case type
        case placeholder
        case actionID = "action_id"
        case options
        case optionGroups = "option_groups"
        case initialOption = "initial_option"
        case confirm
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.type = try container.decode(SlackBlockElementType.self, forKey: .type)
        self.placeholder = try container.decode(SlackTextObject.self, forKey: .placeholder)
        self.actionID = try container.decode(String.self, forKey: .actionID)
        self.options = try container.decode([SlackOptionObject].self, forKey: .options)
        self.optionGroups = try container.decodeIfPresent([SlackOptionGroupObject].self, forKey: .optionGroups)
        
        if let option = try container.decodeIfPresent(SlackOptionObject.self, forKey: .initialOption) {
            self.initialOption = option
        } else if let optionGroup = try container.decodeIfPresent(SlackOptionGroupObject.self, forKey: .initialOption) {
            self.initialOption = optionGroup
        }
        
        self.confirm = try container.decodeIfPresent(SlackConfirmObject.self, forKey: .confirm)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.type, forKey: .type)
        try container.encode(self.placeholder, forKey: .placeholder)
        try container.encode(self.actionID, forKey: .actionID)
        try container.encodeIfPresent(self.options, forKey: .options)
        try container.encodeIfPresent(self.optionGroups, forKey: .optionGroups)
        
        if let option = self.initialOption as? SlackOptionObject {
            try container.encode(option, forKey: .initialOption)
        } else if let optionGroup = self.initialOption as? SlackOptionGroupObject {
            try container.encode(optionGroup, forKey: .initialOption)
        }
        
        try container.encodeIfPresent(self.confirm, forKey: .confirm)
    }
}
