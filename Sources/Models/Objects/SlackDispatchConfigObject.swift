//
//  File.swift
//
//
//  Created by nier on 2021/7/15.
//

import Foundation

public struct SlackDispatchConfigObject: SlackBlockObject, SlackMessageBlockElement, Codable {
    
    public var triggerActionsOn: [Actions]
    
    public init(_ action: Actions) {
        self.triggerActionsOn = [action]
    }
    
    public init(_ actions: [Actions]) {
        self.triggerActionsOn = actions
    }
    
    public enum Actions: String, Codable {
        case enterPressed = "on_enter_pressed"
        case characterEntered = "on_character_entered"
    }
    
    enum CodingKeys: String, CodingKey {
        case triggerActionsOn = "trigger_actions_on"
    }
}
