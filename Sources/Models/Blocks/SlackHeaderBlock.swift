//
//  File.swift
//  
//
//  Created by nier on 2021/7/9.
//

import Foundation

public struct SlackHeaderBlock: SlackMessageBlock, Codable {
    
    public var type: SlackMessageBlockType = .header
    public var text: SlackTextObject
    public var blockID: String?
    
    public init(_ blockID: String? = nil, text: String) {
        self.text = SlackTextObject(plaintext: text)
        self.blockID = blockID
    }
    
    enum CodingKeys: String, CodingKey {
        case type
        case text
        case blockID = "block_id"
    }
}
