//
//  File.swift
//  
//
//  Created by nier on 2021/7/15.
//

import Foundation

public struct SlackMultiChannelsSelectElement: SlackMultiSelectElement, SlackMessageBlockElement, Codable {
    
    public var type: SlackBlockElementType = .multiSelect(.channels)
    public var placeholder: SlackTextObject
    public var actionID: String
    public var initialChannels: [String]?
    public var confirm: SlackConfirmObject?
    public var maxSelectedItems: Int?
    
    public init(_ actionID: String = UUID().uuidString, placeholder: String, initialChannels: [String]? = nil, confirm: SlackConfirmObject? = nil, maxSelectedItems: Int?) {
        self.placeholder = SlackTextObject(plaintext: placeholder)
        self.actionID = actionID
        self.initialChannels = initialChannels
        self.confirm = confirm
        self.maxSelectedItems = maxSelectedItems
    }
    
    enum CodingKeys: String, CodingKey {
        case type
        case placeholder
        case actionID = "action_id"
        case initialChannels = "initial_channels"
        case confirm
        case maxSelectedItems = "max_selected_items"
    }
}
