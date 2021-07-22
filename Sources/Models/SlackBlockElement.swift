//
//  File.swift
//  
//
//  Created by nier on 2021/7/15.
//

import Foundation

// MARK: - [Protocol] SlackBlockElement
/**
 [block_elements]: https://api.slack.com/reference/block-kit/block-elements
 
 Block elements can be used inside of `section`, `context`, `input` and `actions` layout blocks.
 
 # Reference
 
 [Block elements | Slack][block_elements]
 */
public protocol SlackBlockElement: SlackMessageBlockElement {
    var type: SlackBlockElementType { get }
}

// MARK: - SlackBlockElementType
/**
 [composition_objects]: https://api.slack.com/reference/block-kit/composition-objects
 
 Type of Slack block element.
 
 - Button element
 - Checkbox groups
 - Date picker element
 - Image element
 - Multi-select menu element
 - Overflow meun element
 - Plain-text input element
 - Radio button group element
 - Select menu element
 - Time picker element
 
 # Reference
 
 [Composition objects | Slack][composition_objects]
 */
public enum SlackBlockElementType {
    case button
    case checkboxes
    case datepicker
    case image
    case multiSelect(SlackBlockSelectElementType)
    case overflow
    case plainTextInput
    case radioButtons
    case select(SlackBlockSelectElementType)
    case timepicker
    
    var rawValue: String {
        switch self {
        case .multiSelect(let type):
            return "multi_\(type.rawValue)_select"
        case .plainTextInput:
            return "plain_text_input"
        case .radioButtons:
            return "radio_buttons"
        case .select(let type):
            return "\(type.rawValue)_select"
        default:
            return "\(self)"
        }
    }
}

// MARK: - SlackBlockElementType Codable
extension SlackBlockElementType: Codable {
    
    
    // MARK: Decoder
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        
        switch value {
        case "button":
            self = .button
        case "checkboxes":
            self = .checkboxes
        case "datepicker":
            self = .datepicker
        case "image":
            self = .image
        case "overflow":
            self = .overflow
        case "plain_text_input":
            self = .plainTextInput
        case "radio_buttons":
            self = .radioButtons
        case "timepicker":
            self = .timepicker
        default:
            let array = value.components(separatedBy: "_")
            
            guard array.last == "select" else {
                throw DecodingError.dataCorruptedError(in: container, debugDescription: "Value not match.")
            }
            
            let selectType: SlackBlockSelectElementType
            
            if array.first == "multi" {
                selectType = try .init(elementType: array[1])
                self = .multiSelect(selectType)
            } else {
                selectType = try .init(elementType: array[0])
                self = .select(selectType)
            }
        }
    }
    
    // MARK: Encoder
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        try container.encode(self.rawValue)
    }
}

// MARK: - [Protocol] SlackSelectElement
/**
 [Select menu element | Slack](https://api.slack.com/reference/block-kit/block-elements#select)
 */
public protocol SlackSelectElement: SlackBlockElement {
    var placeholder: SlackTextObject { get set }
    var actionID: String { get set }
    var confirm: SlackConfirmObject? { get set }
}

// MARK: - [Protocol] SlackMultiSelectElement
/**
 [Multi-select menu element | Slack](https://api.slack.com/reference/block-kit/block-elements#multi_select)
 */
public protocol SlackMultiSelectElement: SlackSelectElement {
    var maxSelectedItems: Int? { get set }
}

// MARK: - SlackBlockSelectElementType
/**
 Types of select/multi-select menu..
 
 - Static options
 - Extenal data source
 - User list
 - Conversations list
 - Public channels list
 */
public enum SlackBlockSelectElementType: String, Codable {
    case `static`
    case external
    case users
    case conversations
    case channels
    
    init(elementType: String) throws {
        switch elementType {
        case "static":
            self = .static
        case "external":
            self = .external
        case "users":
            self = .users
        case "conversations":
            self = .conversations
        case "channels":
            self = .channels
        default:
            throw SlackBlockSelectElementTypeError.valueNotFound
        }
    }
}

public enum SlackBlockSelectElementTypeError: Error {
        case valueNotFound
}

// MARK: - SlackBlockButtonElementStyle
/**
 Style of Slack button element.
 */
public enum SlackBlockButtonElementStyle: String, Codable {
    case `default`
    case primary
    case danger
}
