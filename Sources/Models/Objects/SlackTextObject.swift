//
//  File.swift
//  
//
//  Created by nier on 2021/7/12.
//

import Foundation

public struct SlackTextObject: SlackBlockObject, SlackMessageBlockElement {
    
    public var type: Type
    public var text: String
    public var emoji: Bool
    public var verbatim: Bool
    
    public enum `Type`: String, Codable {
        case plaintext = "plain_text"
        case markdown = "mrkdwn"
    }
    
    public init(plaintext: String, emoji: Bool = true) {
        self.type = .plaintext
        self.text = plaintext
        self.emoji = emoji
        self.verbatim = false
    }
    
    public init(markdown: String, verbatim: Bool = false) {
        self.type = .markdown
        self.text = markdown
        self.emoji = true
        self.verbatim = verbatim
    }
}

// MARK: - Codable
extension SlackTextObject: Codable {
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.type, forKey: .type)
        try container.encode(self.text, forKey: .text)
        
        switch self.type {
        case .plaintext:
            try container.encode(self.emoji, forKey: .emoji)
        case .markdown:
            try container.encode(self.verbatim, forKey: .verbatim)
        }
    }
}
