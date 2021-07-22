//
//  File.swift
//  
//
//  Created by nier on 2021/7/9.
//

import Foundation

public struct SlackSectionBlock: SlackMessageBlock {
    
    public var type: SlackMessageBlockType = .section
    public var text: SlackTextObject
    public var blockID: String?
    public var fields: [SlackTextObject]?
    public var accessory: SlackBlockElement?
    
    public init(_ blockID: String? = nil, text: SlackTextObject, fields: [SlackTextObject]? = [], accessory: SlackBlockElement? = nil) {
        self.text = text
        self.blockID = blockID
        self.fields = fields
        self.accessory = accessory
    }
    
    public init(_ blockID: String? = nil, plaintext text: String, fields: [SlackTextObject]? = [], accessory: SlackBlockElement? = nil) {
        self.text = SlackTextObject(plaintext: text)
        self.blockID = blockID
        self.fields = fields
        self.accessory = accessory
    }
    
    public init(_ blockID: String? = nil, markdown text: String, fields: [SlackTextObject]? = [], accessory: SlackBlockElement? = nil) {
        self.text = SlackTextObject(markdown: text)
        self.blockID = blockID
        self.fields = fields
        self.accessory = accessory
    }
}

// MARK: - Codable
extension SlackSectionBlock: Codable {
    
    enum CodingKeys: String, CodingKey {
        case type
        case text
        case blockID = "block_id"
        case fields
        case accessory
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.type = try container.decode(SlackMessageBlockType.self, forKey: .type)
        self.text = try container.decode(SlackTextObject.self, forKey: .text)
        self.blockID = try container.decodeIfPresent(String.self, forKey: .blockID)
        self.fields = try container.decodeIfPresent([SlackTextObject].self, forKey: .fields)
        
        if container.contains(.accessory) {
            if let image = try? container.decode(SlackImageElement.self, forKey: .accessory) {
                self.accessory = image
            }
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.type, forKey: .type)
        
        if self.text.text.count > 0 {
            try container.encode(self.text, forKey: .text)
        }
        
        try container.encodeIfPresent(self.blockID, forKey: .blockID)
        
        if let fields = self.fields, fields.count > 0 {
            try container.encode(fields, forKey: .fields)
        }
        
        if let image = self.accessory as? SlackImageElement {
            try container.encode(image, forKey: .accessory)
        }
    }
}
