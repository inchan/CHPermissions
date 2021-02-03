# CHPermission

[![Version](https://img.shields.io/cocoapods/v/CHPermission.svg?style=flat)](http://cocoadocs.org/docsets/CHPermission)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/cocoapods/l/CHPermission.svg?style=flat)](http://cocoadocs.org/docsets/CHPermission)

## About

Swift를 사용하여 iOS 권한을 요청 및 상태확인을 할 수있습니다.

## Requirements
- iOS 10.0+
- Xcode 11+
- Swift 5.0+

## Todo
- [ ] Installation
    - [ ] CocoaPods ... `ing`
    - [x] Carthage
 - [ ] Usage ... `ing`


## Usage

권한 상태 확인  

    let permission: CHPermission = .notification 
    let status = permission.status
    print("\(permission) status: \(status)")
    
    // or 
    let isAuthorized = permission.isAuthorized
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
