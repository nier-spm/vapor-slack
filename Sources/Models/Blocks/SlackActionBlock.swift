//
//  File.swift
//  
//
//  Created by nier on 2021/7/9.
//

import Foundation

public struct SlackActionBlock: SlackMessageBlock {
    
    public var type: SlackMessageBlockType = .actions
    public var elements: [SlackBlockElement] = []
    public var blockID: String?
    
    public init(_ blockID: String? = nil, elements: [SlackBlockElement] = []) {
        self.elements = elements
        self.blockID = blockID
    }
}

extension SlackActionBlock: Codable {
    
    enum CodingKeys: String, CodingKey {
        case type
        case blockID = "block_id"
        case elements
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.type = try container.decode(SlackMessageBlockType.self, forKey: .type)
        
        var unkeyedContainer = try container.nestedUnkeyedContainer(forKey: .elements)
        
        while !unkeyedContainer.isAtEnd {
            if let button = try? unkeyedContainer.decode(SlackButtonElement.self) {
                self.elements.append(button)
            } else if let datePicker = try? unkeyedContainer.decode(SlackDatePickerElement.self) {
                self.elements.append(datePicker)
            } else if let overflow = try? unkeyedContainer.decode(SlackOverflowMeunElement.self) {
                self.elements.append(overflow)
            } else if let staticSelect = try? unkeyedContainer.decode(SlackStaticSelectElement.self) {
                self.elements.append(staticSelect)
            } else if let externalSelect = try? unkeyedContainer.decode(SlackExternalSelectElement.self) {
                self.elements.append(externalSelect)
            } else if let usersSelect = try? unkeyedContainer.decode(SlackUsersSelectElement.self) {
                self.elements.append(usersSelect)
            } else if let conversationsSelect = try? unkeyedContainer.decode(SlackConversationsSelectElement.self) {
                self.elements.append(conversationsSelect)
            } else if let channelsSelect = try? unkeyedContainer.decode(SlackChannelsSelectElement.self) {
                self.elements.append(channelsSelect)
            }
        }
        
        self.blockID = try container.decodeIfPresent(String.self, forKey: .blockID)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.type, forKey: .type)
        
        var unkeyedContainer = container.nestedUnkeyedContainer(forKey: .elements)
        
        for element in self.elements {
            if let button = element as? SlackButtonElement {
                try unkeyedContainer.encode(button)
            } else if let datePicker = element as? SlackDatePickerElement {
                try unkeyedContainer.encode(datePicker)
            } else if let overflow = element as? SlackOverflowMeunElement {
                try unkeyedContainer.encode(overflow)
            } else if let staticSelect = element as? SlackStaticSelectElement {
                try unkeyedContainer.encode(staticSelect)
            } else if let externalSelect = element as? SlackExternalSelectElement {
                try unkeyedContainer.encode(externalSelect)
            } else if let usersSelect = element as? SlackUsersSelectElement {
                try unkeyedContainer.encode(usersSelect)
            } else if let conversationsSelect = element as? SlackConversationsSelectElement {
                try unkeyedContainer.encode(conversationsSelect)
            } else if let channelsSelect = element as? SlackChannelsSelectElement {
                try unkeyedContainer.encode(channelsSelect)
            }
        }
        
        try container.encodeIfPresent(blockID, forKey: .blockID)
    }
}
