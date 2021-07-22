//
//  File.swift
//  
//
//  Created by nier on 2021/7/9.
//

import Foundation

public struct SlackFileBlock: SlackMessageBlock, Codable {
    
    public var type: SlackMessageBlockType = .file
    public var externalID: String
    public var source: String
    public var blockID: String?
    
    public init(_ blockID: String? = nil, externalID: String, source: String) {
        self.externalID = externalID
        self.source = source
        self.blockID = blockID
    }
    
    enum CodingKeys: String, CodingKey {
        case type
        case externalID = "external_id"
        case source
        case blockID = "block_id"
    }
}
