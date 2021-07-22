//
//  File.swift
//  
//
//  Created by nier on 2021/7/9.
//

import Vapor

public struct SlackMessageResponse: Content {
    
    public var success: Bool
    public var channel: String
    public var time: Date
    public var message: String
    public var error: String
    public var responseMetadata: ResponseMetadata?
}

// MARK: - Codable
extension SlackMessageResponse {
    
    enum CodingKeys: String, CodingKey {
        case success = "ok"
        case channel
        case time = "ts"
        case message
        case error
        case responseMetadata = "response_metadata"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.success = try container.decode(Bool.self, forKey: .success)
        
        if self.success {
            self.channel = try container.decode(String.self, forKey: .channel)
            
            let timestamp: String = try container.decode(String.self, forKey: .time)
            
            self.time = Date(timeIntervalSince1970: TimeInterval(timestamp)!)
            self.message = ""
            self.error = ""
        } else {
            self.channel = ""
            self.time = Date()
            self.message = ""
            
            self.error = try container.decode(String.self, forKey: .error)
        }
        
        self.responseMetadata = try container.decodeIfPresent(ResponseMetadata.self, forKey: .responseMetadata)
    }
}

// MARK: - ResponseMetadata
extension SlackMessageResponse {
    
    public struct ResponseMetadata: Content {
        
        public var warnings: [String]
        public var messages: [String]
        
        enum CodingKeys: String, CodingKey {
            case warnings
            case messages
        }
        
        public init() {
            self.warnings = []
            self.messages = []
        }
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.warnings = try container.decodeIfPresent([String].self, forKey: .warnings) ?? []
            self.messages = try container.decodeIfPresent([String].self, forKey: .messages) ?? []
        }
    }
}
