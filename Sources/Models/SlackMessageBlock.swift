//
//  File.swift
//  
//
//  Created by nier on 2021/7/9.
//

import Foundation

// MARK: - [Protocol] SlackMessageBlock
/**
 [blocks]: https://api.slack.com/reference/block-kit/blocks
 
 Blocks are a series of components that can be combined to create visually rich and compellingly interactive messages.
 
 # Reference
 
 [Layout blocks | Slack][blocks]
 */
public protocol SlackMessageBlock {
    var type: SlackMessageBlockType { get }
    var blockID: String? { get set }
}

// MARK: - SlackMessageBlockType
/**
 Type of Slack block.
 
 - Actions Block
 - Context Block
 - Divider Block
 - File Block
 - Header Block
 - Image Block
 - Input Block
 - Section Block
 */
public enum SlackMessageBlockType: String, Codable {
    case actions
    case context
    case divider
    case file
    case header
    case image
    case input
    case section
}

// MARK: - [Protocol] SlackMessageBlockElement
public protocol SlackMessageBlockElement {}
