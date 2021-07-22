//
//  File.swift
//  
//
//  Created by nier on 2021/7/15.
//

import Foundation

public struct SlackChannelsSelectElement: SlackSelectElement, SlackMessageBlockElement, Codable {
    
    public var type: SlackBlockElementType = .select(.channels)
    public var placeholder: SlackTextObject
    public var actionID: String
    public var initialChannel: String?
    public var confirm: SlackConfirmObject?
    public var responseURLEnabled: Bool?
    
    public init(_ actionID: String = UUID().uuidString, placeholder: String, initialChannel: String? = nil, confirm: SlackConfirmObject? = nil, responseURLEnabled: Bool? = nil) {
        self.placeholder = SlackTextObject(plaintext: placeholder)
        self.actionID = actionID
        self.initialChannel = initialChannel
        self.confirm = confirm
        self.responseURLEnabled = responseURLEnabled
    }
    
    enum CodingKeys: String, CodingKey {
        case type
        case placeholder
        case actionID = "actionID"
        case initialChannel = "initial_channel"
        case confirm
        case responseURLEnabled = "response_url_enabled"
    }
}
