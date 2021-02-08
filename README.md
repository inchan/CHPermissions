# CHPermissions

[![CI Status](https://img.shields.io/travis/enliple-kay/CHPermissions.svg?style=flat)](https://travis-ci.org/enliple-kay/CHPermissions)
[![Version](https://img.shields.io/cocoapods/v/CHPermissions.svg?style=flat)](https://cocoapods.org/pods/CHPermissions)
[![License](https://img.shields.io/cocoapods/l/CHPermissions.svg?style=flat)](https://cocoapods.org/pods/CHPermissions)
[![Platform](https://img.shields.io/cocoapods/p/CHPermissions.svg?style=flat)](https://cocoapods.org/pods/CHPermissions)

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

## About

Swift를 사용하여 iOS 권한을 요청 및 상태확인을 할 수있습니다.

## Features

- [x] Installation
    - [x] CocoaPods 
    - [x] Carthage
- [ ] Supported Rx-Framework (RxSwift, RxCocoa)
- [ ] Usage ... `ing`
- [x] Example Project

## Requirements

- iOS 10.0+
- Xcode 11+
- Swift 5.0+

## Installation

CHPermissions is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'CHPermissions'
```

## Usage

권한 상태 확인  

    let permission: CHPermission = .notification
    let status = permission.status
    print("\(permission) status: \(status)")

    // or
    let isAuthorized = status.isAuthorized
    print("\(permission) isAuthorized: \(isAuthorized)")

권한 요청  

    let permission: CHPermission = .notification 
    permission.request { status in          
        let isAuthorized = (status == .authorized)  
        // or 
        switch status {
        case .notDetermined:
            ... 
        case .restricted:
            ...
        case .denied:
            ... 
        case .authorized:
            ... 
        @unknown default:
            return .denied
        }
    }

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Author

inchan kangsazang@gmail.com

## License

CHPermissions is available under the MIT license. See the LICENSE file for more info.
