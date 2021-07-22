//
//  File.swift
//  
//
//  Created by nier on 2021/7/9.
//

import Foundation

public struct SlackDividerBlock: SlackMessageBlock, Codable {
    
    public var type: SlackMessageBlockType = .divider
    public var blockID: String?
    
    public init(_ blockID: String? = nil) {
        self.blockID = blockID
    }
    
    enum CodingKeys: String, CodingKey {
        case type
        case blockID = "block_id"
    }
}
