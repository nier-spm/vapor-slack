//
//  File.swift
//  
//
//  Created by nier on 2021/7/15.
//

import Foundation

public struct SlackRadioButtonGroupElement: SlackBlockElement, SlackMessageBlockElement, Codable {
    
    public var type: SlackBlockElementType = .radioButtons
    public var actionID: String
    public var options: [String] // option objects
    public var initialOption: [String]? // option object
    public var confirm: SlackConfirmObject?
    
    public init(_ actionID: String = UUID().uuidString, options: [String] = [], initialOption: [String]? = nil, confirm: SlackConfirmObject? = nil) {
        self.actionID = actionID
        self.options = options
        self.initialOption = initialOption
        self.confirm = confirm
    }
    
    enum CodingKeys: String, CodingKey {
        case type
        case actionID = "action_id"
        case options
        case initialOption = "initial_option"
        case confirm
    }
}
