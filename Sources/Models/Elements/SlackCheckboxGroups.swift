//
//  File.swift
//  
//
//  Created by nier on 2021/7/14.
//

import Foundation

public struct SlackCheckboxGroups: SlackBlockElement, SlackMessageBlockElement, Codable {
    
    public var type: SlackBlockElementType = .checkboxes
    public var actionID: String
    public var options: [String] // option objects
    public var initialOptions: [String]? // option objects
    public var confirm: SlackConfirmObject?
    
    public init(_ actionID: String = UUID().uuidString, options: [String] = [], initialOptions: [String]? = nil, confirm: SlackConfirmObject? = nil) {
        self.actionID = actionID
        self.options = options
        self.initialOptions = initialOptions
        self.confirm = confirm
    }
    
    enum CodingKeys: String, CodingKey {
        case type
        case actionID = "action_id"
        case options
        case initialOptions = "initial_options"
        case confirm
    }
}
