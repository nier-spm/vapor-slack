//
//  File.swift
//
//
//  Created by nier on 2021/7/15.
//

import Foundation

public struct SlackFilterObject: SlackBlockObject, SlackMessageBlockElement, Codable {
    
    public var include: [FilterOption]
    public var excludeExternalSharedChannels: Bool?
    public var excludeBotUsers: Bool?
    
    public init(_ option: FilterOption, excludeExternalSharedChannels: Bool? = nil, excludeBotUsers: Bool? = nil) {
        self.include = [option]
        self.excludeExternalSharedChannels = excludeExternalSharedChannels
        self.excludeBotUsers = excludeBotUsers
    }
    
    public init(_ options: [FilterOption], excludeExternalSharedChannels: Bool? = nil, excludeBotUsers: Bool? = nil) {
        self.include = options
        self.excludeExternalSharedChannels = excludeExternalSharedChannels
        self.excludeBotUsers = excludeBotUsers
    }
    
    public enum FilterOption: String, Codable {
        case im
        case mpim
        case `private`
        case `public`
    }
    
    enum CodingKeys: String, CodingKey {
        case include
        case excludeExternalSharedChannels = "exclude_external_shared_channels"
        case excludeBotUsers = "exclude_bot_users"
    }
}
