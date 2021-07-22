//
//  File.swift
//  
//
//  Created by nier on 2021/7/9.
//

import Foundation

public struct SlackInputBlock: SlackMessageBlock {
    
    public var type: SlackMessageBlockType = .input
    public var label: SlackTextObject
    public var element: SlackBlockElement
    public var dispatchAction: Bool?
    public var blockID: String?
    public var hint: [SlackTextObject]?
    public var optional: Bool?
    
    public init(_ blockID: String? = nil, label: SlackTextObject, element: SlackBlockElement, dispatchAction: Bool? = nil, hint: [SlackTextObject]? = nil, optional: Bool? = nil) {
        self.label = label
        self.element = element
        self.dispatchAction = dispatchAction
        self.blockID = blockID
        self.hint = hint
        self.optional = optional
    }
    
    public init(_ blockID: String? = nil, label: String, element: SlackBlockElement, dispatchAction: Bool? = nil, hint: [String]? = nil, optional: Bool? = nil) {
        self.label = SlackTextObject(plaintext: label)
        self.element = element
        self.dispatchAction = dispatchAction
        self.blockID = blockID
        self.hint = hint?.map { SlackTextObject(plaintext: $0) }
        self.optional = optional
    }
}

// MARK: - Codable
extension SlackInputBlock: Codable {
    
    enum CodingKeys: String, CodingKey {
        case type
        case label
        case element
        case dispatchAction = "dispatch_action"
        case blockID = "block_id"
        case hint
        case optional
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.type = try container.decode(SlackMessageBlockType.self, forKey: .type)
        self.label = try container.decode(SlackTextObject.self, forKey: .label)
        
        if let checkboxgroups = try? container.decode(SlackCheckboxGroups.self, forKey: .element) {
            self.element = checkboxgroups
        } else if let datePicker = try? container.decode(SlackDatePickerElement.self, forKey: .element) {
            self.element = datePicker
        } else if let plainTextInput = try? container.decode(SlackPlainTextInputElement.self, forKey: .element) {
            self.element = plainTextInput
        } else if let raidoButtonGroup = try? container.decode(SlackRadioButtonGroupElement.self, forKey: .element) {
            self.element = raidoButtonGroup
        } else if let multiStaticSelect = try? container.decode(SlackMultiStaticSelectElement.self, forKey: .element) {
            self.element = multiStaticSelect
        } else if let multiExternalSelect = try? container.decode(SlackMultiExternalSelectElement.self, forKey: .element) {
            self.element = multiExternalSelect
        } else if let multiUsersSelect = try? container.decode(SlackMultiUsersSelectElement.self, forKey: .element) {
            self.element = multiUsersSelect
        } else if let multiConversationsSelect = try? container.decode(SlackMultiConversationsSelectElement.self, forKey: .element) {
            self.element = multiConversationsSelect
        } else if let multiChannelsSelect = try? container.decode(SlackMultiChannelsSelectElement.self, forKey: .element) {
            self.element = multiChannelsSelect
        } else if let staticSelect = try? container.decode(SlackStaticSelectElement.self, forKey: .element) {
            self.element = staticSelect
        } else if let externalSelect = try? container.decode(SlackExternalSelectElement.self, forKey: .element) {
            self.element = externalSelect
        } else if let usersSelect = try? container.decode(SlackUsersSelectElement.self, forKey: .element) {
            self.element = usersSelect
        } else if let conversationsSelect = try? container.decode(SlackConversationsSelectElement.self, forKey: .element) {
            self.element = conversationsSelect
        } else {
            self.element = try container.decode(SlackChannelsSelectElement.self, forKey: .element)
        }
        
        self.dispatchAction = try container.decodeIfPresent(Bool.self, forKey: .dispatchAction)
        self.blockID = try container.decodeIfPresent(String.self, forKey: .blockID)
        
        if container.contains(.hint) {
            self.hint = []

            var unkeyedContainer = try container.nestedUnkeyedContainer(forKey: .hint)

            while !unkeyedContainer.isAtEnd {
                if let text = try? unkeyedContainer.decode(SlackTextObject.self) {
                    self.hint?.append(text)
                }
            }
        }
        
        self.optional = try container.decodeIfPresent(Bool.self, forKey: .optional)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.type, forKey: .type)
        try container.encode(self.label, forKey: .label)
        
        if let checkboxgroups = self.element as? SlackCheckboxGroups {
            try container.encode(checkboxgroups, forKey: .element)
        } else if let datePicker = self.element as? SlackDatePickerElement {
            try container.encode(datePicker, forKey: .element)
        } else if let plainTextInput = self.element as? SlackPlainTextInputElement {
            try container.encode(plainTextInput, forKey: .element)
        } else if let raidoButtonGroup = self.element as? SlackRadioButtonGroupElement {
            try container.encode(raidoButtonGroup, forKey: .element)
        } else if let multiStaticSelect = self.element as? SlackMultiStaticSelectElement {
            try container.encode(multiStaticSelect, forKey: .element)
        } else if let multiExternalSelect = self.element as? SlackMultiExternalSelectElement {
            try container.encode(multiExternalSelect, forKey: .element)
        } else if let multiUsersSelect = self.element as? SlackMultiUsersSelectElement {
            try container.encode(multiUsersSelect, forKey: .element)
        } else if let multiConversationsSelect = self.element as? SlackMultiConversationsSelectElement {
            try container.encode(multiConversationsSelect, forKey: .element)
        } else if let multiChannelsSelect = self.element as? SlackMultiChannelsSelectElement {
            try container.encode(multiChannelsSelect, forKey: .element)
        } else if let staticSelect = self.element as? SlackStaticSelectElement {
            try container.encode(staticSelect, forKey: .element)
        } else if let externalSelect = self.element as? SlackExternalSelectElement {
            try container.encode(externalSelect, forKey: .element)
        } else if let usersSelect = self.element as? SlackUsersSelectElement {
            try container.encode(usersSelect, forKey: .element)
        } else if let conversationsSelect = self.element as? SlackConversationsSelectElement {
            try container.encode(conversationsSelect, forKey: .element)
        } else if let channelsSelect = self.element as? SlackChannelsSelectElement {
            try container.encode(channelsSelect, forKey: .element)
        }
        
        try container.encodeIfPresent(self.dispatchAction, forKey: .dispatchAction)
        try container.encodeIfPresent(self.blockID, forKey: .blockID)
        
        if let hint = self.hint {
            try container.encode(hint, forKey: .hint)
        }
        
        try container.encodeIfPresent(self.optional, forKey: .optional)
    }
}
