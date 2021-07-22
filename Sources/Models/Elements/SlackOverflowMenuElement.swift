//
//  File.swift
//  
//
//  Created by nier on 2021/7/14.
//

import Foundation

public struct SlackOverflowMeunElement: SlackBlockElement, SlackMessageBlockElement, Codable {
    
    public var type: SlackBlockElementType = .overflow
    public var actionID: String
    public var options: [String] // option objects
    public var confirm: [String]?
    
    public init(_ actionID: String = UUID().uuidString, options: [String] = [], confirm: [String]? = nil) {
        self.actionID = actionID
        self.options = options
        self.confirm = confirm
    }
    
    enum CodingKeys: String, CodingKey {
        case type
        case actionID = "action_id"
        case options
        case confirm
    }
}
