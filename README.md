DIAttribute
===

[WIP] DIAttribute introduces dependency injection attribute.

# Installation

You can install this framework with Swift Package Manager in Xcode 11.

# Feature

## Inject protocol values

```swift
final class ViewController: UIViewController {
    @Inject(Self.self) var apiClient: APIClientProtocol
    
    ...
}

// Production
DIResolver.register(ViewController.self, keyPath: \.apiClient, value: ProductionAPIClient())

// Test
DIResolver.register(ViewController.self, keyPath: \.apiClient, value: MockAPIClient())
```

## Inject multiple values

```swift
struct Environment {
    @Inject(Self.self) var endpoint: URL
    @Inject(Self.self) var timeZone: TimeZone
}

DIResolver.register(Environment.self) {
    Register(URL.self, URL(string: "https://example.com")!)
    Register(TimeZone.self, TimeZone(identifier: "Asia/Tokyo")!)
}
```

# License
DIAttribute is released under the MIT license. See LICENSE for details.
