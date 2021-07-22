import Vapor

public struct SlackMessagePayload: Content {
    
    public var channel: String
    public var text: String
    public var blocks: [SlackMessageBlock] = []
    
    public init(channel: String, text: String = "", blocks: [SlackMessageBlock] = []) {
        self.channel = channel
        self.text = text
        self.blocks = blocks
    }
}

// MARK: - Codable
extension SlackMessagePayload {
    
    enum CodingKeys: String, CodingKey {
        case channel
        case text
        case blocks
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        var channelName: String = try container.decode(String.self, forKey: .channel)
        
        channelName.removeFirst()
        
        self.channel = channelName
        self.text = try container.decode(String.self, forKey: .text)
        
        var unkeyedContainer = try container.nestedUnkeyedContainer(forKey: .blocks)

        while !unkeyedContainer.isAtEnd {
            if let action = try? unkeyedContainer.decode(SlackActionBlock.self) {
                self.blocks.append(action)
            } else if let context = try? unkeyedContainer.decode(SlackContextBlock.self) {
                self.blocks.append(context)
            } else if let divider = try? unkeyedContainer.decode(SlackDividerBlock.self) {
                self.blocks.append(divider)
            } else if let file = try? unkeyedContainer.decode(SlackFileBlock.self) {
                self.blocks.append(file)
            } else if let header = try? unkeyedContainer.decode(SlackHeaderBlock.self) {
                self.blocks.append(header)
            } else if let image = try? unkeyedContainer.decode(SlackImageBlock.self) {
                self.blocks.append(image)
            } else if let input = try? unkeyedContainer.decode(SlackInputBlock.self) {
                self.blocks.append(input)
            } else if let section = try? unkeyedContainer.decode(SlackSectionBlock.self) {
                self.blocks.append(section)
            }
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode("#\(self.channel)", forKey: .channel)
        try container.encode(self.text, forKey: .text)
        
        if self.blocks.count > 0 {
            var unkeyedContainer = container.nestedUnkeyedContainer(forKey: .blocks)
            
            for block in self.blocks {
                if let action = block as? SlackActionBlock {
                    try unkeyedContainer.encode(action)
                } else if let context = block as? SlackContextBlock {
                    try unkeyedContainer.encode(context)
                } else if let divider = block as? SlackDividerBlock {
                    try unkeyedContainer.encode(divider)
                } else if let file = block as? SlackFileBlock {
                    try unkeyedContainer.encode(file)
                } else if let header = block as? SlackHeaderBlock {
                    try unkeyedContainer.encode(header)
                } else if let image = block as? SlackImageBlock {
                    try unkeyedContainer.encode(image)
                } else if let input = block as? SlackInputBlock {
                    try unkeyedContainer.encode(input)
                } else if let section = block as? SlackSectionBlock {
                    try unkeyedContainer.encode(section)
                }
            }
        }
    }
}
