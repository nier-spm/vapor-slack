//
//  File.swift
//  
//
//  Created by nier on 2021/7/15.
//

import Foundation

public struct SlackOptionGroupObject: SlackBlockObject, SlackMessageBlockElement, Codable {
    
    public var label: SlackTextObject
    public var options: [SlackOptionObject]
    
    public init(label: String, options: [SlackOptionObject] = []) {
        self.label = SlackTextObject(plaintext: label)
        self.options = options
    }
}
