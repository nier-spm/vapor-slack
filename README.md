# Vapor Slack

A Vapor extension package for [Slack Messaging Api](https://api.slack.com/messaging)

## Features

- [x] Message payload for Slack block message
- [x] Message to specify channel for Slack bot

## Installation

### Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/nier-spm/vapor-slack.git", from: "0.0.1")
],
```

## Usage

```swift
// Package.swift
targets: [
    .target(
        name: "App",
        dependencies: [
            .product(name: "VaporSlack", package: "VaporSlack"),
            ...
        ],
    }
],
```

## Import

```swift
import VaporSlack
```

## Setup Configuration

Setup **`Slack bot user OAuth token`** before register vapor routes

```swift
// configure.swift
import Vapor
import VaporSlack

public func configure(_ app: Application) throws {
    let token: String = "{{your_bot_oauth_token}}"
    
    app.slack = SlackConfigutaion(token)
    
    try routes(app)
}
```

or set bot token from enviornment.

```swift
// configure.swift
import Vapor
import VaporSlack

public func configure(_ app: Application) throws {
    let key: String = "{{your_bot_oauth_token_key}}"
    
    app.slack = try SlackConfigutaion.enviornment(key)
    
    try routes(app)
}
```

### Send Message

```swift
let payload: SlackMessagePayload = SlackMessagePayload(channel: "your_slack_channel")    
let request: Request = Request()    // Client Request

request.slack.message(payload)      // Client Response
```
