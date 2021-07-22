//
//  File.swift
//  
//
//  Created by nier on 2021/7/15.
//

import Foundation

public struct SlackMultiExternalSelectElement: SlackMultiSelectElement, SlackMessageBlockElement {
    
    public var type: SlackBlockElementType = .multiSelect(.external)
    public var placeholder: SlackTextObject
    public var actionID: String
    public var minQueryLength: Int?
    public var initialOptions: [SlackBlockObject]?
    public var confirm: SlackConfirmObject?
    public var maxSelectedItems: Int?
    
    public init(_ actionID: String = UUID().uuidString, placeholder: String, minQueryLength: Int? = nil, initialOptions: [SlackBlockObject]? = nil, confirm: SlackConfirmObject? = nil, maxSelectedItems: Int?) {
        self.placeholder = SlackTextObject(plaintext: placeholder)
        self.actionID = actionID
        self.minQueryLength = minQueryLength
        self.initialOptions = initialOptions
        self.confirm = confirm
        self.maxSelectedItems = maxSelectedItems
    }
}

// MARK: - Codable
extension SlackMultiExternalSelectElement: Codable {
    
    enum CodingKeys: String, CodingKey {
        case type
        case placeholder
        case actionID = "action_id"
        case minQueryLength = "min_query_length"
        case initialOptions = "initial_options"
        case confirm
        case maxSelectedItems = "max_selected_items"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.type = try container.decode(SlackBlockElementType.self, forKey: .type)
        self.placeholder = try container.decode(SlackTextObject.self, forKey: .placeholder)
        self.actionID = try container.decode(String.self, forKey: .actionID)
        self.minQueryLength = try container.decodeIfPresent(Int.self, forKey: .minQueryLength)
        
        if container.contains(.initialOptions) {
            self.initialOptions = []
            var unkeyedContainer = try container.nestedUnkeyedContainer(forKey: .initialOptions)
            
            while !unkeyedContainer.isAtEnd {
                if let option = try? unkeyedContainer.decode(SlackOptionObject.self) {
                    self.initialOptions?.append(option)
                } else if let optionGroup = try? unkeyedContainer.decode(SlackOptionGroupObject.self) {
                    self.initialOptions?.append(optionGroup)
                }
            }
        }
        
        self.confirm = try container.decodeIfPresent(SlackConfirmObject.self, forKey: .confirm)
        self.maxSelectedItems = try container.decodeIfPresent(Int.self, forKey: .maxSelectedItems)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.type, forKey: .type)
        try container.encode(self.placeholder, forKey: .placeholder)
        try container.encode(self.actionID, forKey: .actionID)
        try container.encodeIfPresent(self.minQueryLength, forKey: .minQueryLength)
        
        if let initialOptions = self.initialOptions, initialOptions.count > 0 {
            var unkeyedContainer = container.nestedUnkeyedContainer(forKey: .initialOptions)
            
            for initialOption in initialOptions {
                if let option = initialOption as? SlackOptionObject {
                    try unkeyedContainer.encode(option)
                } else if let optionGroup = initialOption as? SlackOptionGroupObject {
                    try unkeyedContainer.encode(optionGroup)
                }
            }
        }
        
        try container.encodeIfPresent(self.confirm, forKey: .confirm)
        try container.encodeIfPresent(self.maxSelectedItems, forKey: .maxSelectedItems)
    }
}
