//
//  File.swift
//  
//
//  Created by nier on 2021/7/9.
//

import Foundation

public struct SlackContextBlock: SlackMessageBlock {
    
    public var type: SlackMessageBlockType = .context
    public var elements: [SlackMessageBlockElement] = []
    public var blockID: String?
    
    public init(_ blockID: String? = nil, elements: [SlackMessageBlockElement] = []) {
        self.elements = elements
        self.blockID = blockID
    }
}

extension SlackContextBlock: Codable {
    
    enum CodingKeys: String, CodingKey {
        case type
        case blockID = "block_id"
        case elements
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.type = try container.decode(SlackMessageBlockType.self, forKey: .type)
        
        var unkeyedContainer = try container.nestedUnkeyedContainer(forKey: .elements)
        
        while !unkeyedContainer.isAtEnd {
            if let text = try? unkeyedContainer.decode(SlackTextObject.self) {
                self.elements.append(text)
            } else if let image = try? unkeyedContainer.decode(SlackImageElement.self) {
                self.elements.append(image)
            }
        }
        
        self.blockID = try container.decodeIfPresent(String.self, forKey: .blockID)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.type, forKey: .type)
        
        var unkeyedContainer = container.nestedUnkeyedContainer(forKey: .elements)
        
        for element in self.elements {
            if let text = element as? SlackTextObject {
                try unkeyedContainer.encode(text)
            } else if let image = element as? SlackImageElement {
                try unkeyedContainer.encode(image)
            }
        }
        
        try container.encodeIfPresent(self.blockID, forKey: .blockID)
    }
}
