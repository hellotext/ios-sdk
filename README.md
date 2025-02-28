# Hellotext

[![CI Status](https://img.shields.io/travis/Breno Morais/Hellotext.svg?style=flat)](https://travis-ci.org/Breno Morais/Hellotext)
[![Version](https://img.shields.io/cocoapods/v/Hellotext.svg?style=flat)](https://cocoapods.org/pods/Hellotext)
[![License](https://img.shields.io/cocoapods/l/Hellotext.svg?style=flat)](https://cocoapods.org/pods/Hellotext)
[![Platform](https://img.shields.io/cocoapods/p/Hellotext.svg?style=flat)](https://cocoapods.org/pods/Hellotext)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

Hellotext is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Hellotext'
```

## Usage
Hellotext SDK will automatically track important events in your application.

To manually trigger an event, use the following code:
```ruby
Hellotext.shared.track(action: "Action", appParameters: ["Key": "Value"])
```

## Author

Breno Morais, brenomorais88@gmail.com

## License

Hellotext is available under the MIT license. See the LICENSE file for more info.
