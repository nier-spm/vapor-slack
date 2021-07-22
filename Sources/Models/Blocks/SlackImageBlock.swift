//
//  File.swift
//  
//
//  Created by nier on 2021/7/9.
//

import Foundation

public struct SlackImageBlock: SlackMessageBlock, Codable {
    
    public var type: SlackMessageBlockType = .image
    public var imageURL: String
    public var altText: String
    public var title: SlackTextObject?
    public var blockID: String?
    
    public init(_ blockID: String? = nil, imageURL: String, altText: String, title: String? = nil) {
        self.imageURL = imageURL
        self.altText = altText
        self.title = title != nil ? SlackTextObject(plaintext: title!) : nil
        self.blockID = blockID
    }
    
    enum CodingKeys: String, CodingKey {
        case type
        case imageURL = "image_url"
        case altText = "alt_text"
        case title
        case blockID = "block_id"
    }
}
