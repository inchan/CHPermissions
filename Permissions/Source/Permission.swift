//
//  ICPermission.swift
//  Permissioners
//
//  Created by kay on 2020/12/14.
//

import Foundation

class NotSupportedPermission: NSObject, PermissionProtocol {
    func request(completion: @escaping Clouser.Completion) {
        completion(.error(.notSupportedPermission))
    }
}

enum Permission: Int, CaseIterable {
    
    case notification
    case camera
    case photoLibrary
    case microphone
    case contacts
    case calendar
    case reminders
    case speech
    case location
    case motion
    case mediaLibrary
    case bluetooth
    case tracking
    
    public var name: String {
        return "\(self)"
    }

    public var status: Status {
        guard needAddUsageDescription == false else {
            let error: Status = .error(.needToUsageDescription(usageDescriptionText))
            print("error: \(error)")
            return .error(.needToUsageDescription(usageDescriptionText))
        }
        return Permission.manager(for: self).status
    }
    
    public func request(completion: @escaping Clouser.Completion) {
        switch self.status {
        case .error, .authorized:
            completion(self.status)
            return
        default:
            Permission.manager(for: self).request(completion: completion)
        }
    }
}

extension Permission {
    
    var needAddUsageDescription: Bool {
        guard let usageDescriptionKey = usageDescriptionKey else { return false }
        return (Bundle.main.infoDictionary?[usageDescriptionKey] == nil)
    }
    
    var usageDescriptionKey: String? {
        switch self {
        case .notification:
            return nil
        case .camera:
            return "NSCameraUsageDescription"
        case .photoLibrary:
            return "NSPhotoLibraryUsageDescription"
        case .microphone:
            return "NSMicrophoneUsageDescription"
        case .contacts:
            return "NSContactsUsageDescription"
        case .calendar:
            return "NSCalendarsUsageDescription"
        case .reminders:
            return "NSRemindersUsageDescription"
        case .speech:
            return "NSSpeechRecognitionUsageDescription"
        case .location:
            return "NSLocationAlwaysAndWhenInUseUsageDescription"
        case .motion:
            return "NSMotionUsageDescription"
        case .mediaLibrary:
            return "NSAppleMusicUsageDescription"
        case .bluetooth:
            return "NSContactsUsageDescription"
        case .tracking:
            return "NSUserTrackingUsageDescription"
        }
    }
    
    var usageDescriptionText: String {
        guard let key = usageDescriptionKey else { return "" }
        return "Missing info.plist key for '\(key)'"
    }
    
    private static func manager(for permission: Permission) -> PermissionProtocol {
        switch permission {
        case .notification: return NotificationPermission()
        case .camera: return NotSupportedPermission()
        case .photoLibrary: return NotSupportedPermission()
        case .microphone: return NotSupportedPermission()
        case .contacts: return ContactsPermission()
        case .calendar: return NotSupportedPermission()
        case .reminders: return NotSupportedPermission()
        case .speech: return NotSupportedPermission()
        case .location: return NotSupportedPermission()
        case .motion: return NotSupportedPermission()
        case .mediaLibrary: return NotSupportedPermission()
        case .bluetooth: return BluetoothPermission()
        case .tracking: return NotSupportedPermission()
        }
    }
}


//class NotificationPermission: NSObject, PermissionProtocol { }
//class CameraPermission: NSObject, PermissionProtocol { }
//class PhotoLibraryPermission: NSObject, PermissionProtocol { }
//class MicrophonePermission: NSObject, PermissionProtocol { }
//class TrackingPermission: NSObject, PermissionProtocol { }
//class TrackingPermission: NSObject, PermissionProtocol { }
