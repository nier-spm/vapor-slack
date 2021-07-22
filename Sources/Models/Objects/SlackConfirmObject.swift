//
//  File.swift
//  
//
//  Created by nier on 2021/7/15.
//

import Foundation

public struct SlackConfirmObject: SlackBlockObject, SlackMessageBlockElement, Codable {
    
    public var title: SlackTextObject
    public var text: SlackTextObject
    public var confirm: SlackTextObject
    public var deny: SlackTextObject
    public var style: SlackBlockButtonElementStyle?
    
    public init(title: SlackTextObject, text: SlackTextObject, confirm: SlackTextObject, deny: SlackTextObject, style: SlackBlockButtonElementStyle? = nil) {
        self.title = title
        self.text = text
        self.confirm = confirm
        self.deny = deny
        self.style = style
    }
    
    public init(title: String, text: SlackTextObject, confirm: String, deny: String, style: SlackBlockButtonElementStyle? = nil) {
        self.title = SlackTextObject(plaintext: title)
        self.text = text
        self.confirm = SlackTextObject(plaintext: confirm)
        self.deny = SlackTextObject(plaintext: deny)
        self.style = style
    }
}
