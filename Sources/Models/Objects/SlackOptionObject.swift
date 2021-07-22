//
//  File.swift
//  
//
//  Created by nier on 2021/7/15.
//

import Foundation

public struct SlackOptionObject: SlackBlockObject, SlackMessageBlockElement, Codable {
    
    public var text: SlackTextObject
    public var value: String
    public var description: SlackTextObject?
    public var url: String?
    
    public init(text: SlackTextObject, value: String, description: String? = nil, url: String? = nil) {
        self.text = text
        self.value = value
        self.description = description != nil ? SlackTextObject(plaintext: description!) : nil
        self.url = url
    }
}
