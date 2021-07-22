//
//  File.swift
//  
//
//  Created by nier on 2021/7/12.
//

import Foundation

public struct SlackImageElement: SlackBlockElement, SlackMessageBlockElement, Codable {
    
    public var type: SlackBlockElementType = .image
    public var imageURL: String
    public var altText: String
    
    public init(_ imageURL: String, altText: String) {
        self.imageURL = imageURL
        self.altText = altText
    }
    
    enum CodingKeys: String, CodingKey {
        case type
        case imageURL = "image_url"
        case altText = "alt_text"
    }
}
