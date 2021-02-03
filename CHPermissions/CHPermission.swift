//
//  CHPermission.swift
//  Permissioners
//
//  Created by kay on 2020/12/14.
//

import Foundation

public enum CHPermission: Int, CaseIterable {
    
    case contacts
    case calendar
    case notification
    case camera
    case photoLibrary
    case microphone
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

    public var status: CHStatus {
        let status = CHPermission.get(for: self).status
        
        guard status != .error(.notSupportedPermission) else {
            return .error(.notSupportedPermission)
        }
        
        guard needAddUsageDescription == false else {
            let error: CHStatus = .error(.needToUsageDescription(usageDescriptionText))
            return error
        }
        return status
    }
    
    public func request(completion: @escaping CHClouser.Completion) {
        switch self.status {
        case .error, .authorized:
            completion(self.status)
            return
        default:
            DispatchQueue.global().async {
                CHPermission.get(for: self).request {
                    DispatchQueue.main.async {
                        completion(self.status)
                    }
                }
            }
        }
    }
}


extension CHPermission {
    
    // 퍼미션 객체를 담아둘 캐시
    private static var PermissionCache: [String: CHPermissionable] = [:]

    private static func get(for permission: CHPermission) -> CHPermissionable {
        if PermissionCache[permission.name] == nil {
            PermissionCache[permission.name] = {
                switch permission {
                case .notification: return NotificationPermission()
                case .camera:       return CameraPermission()
                case .photoLibrary: return PhotoLibraryPermission()
                case .microphone: return MicrophonePermission()
                case .contacts:     return ContactsPermission()
                case .calendar:   return CalendarPermission()
                //case .reminders:  return NotSupportedPermission()
                //case .speech:     return NotSupportedPermission()
                //case .location:   return NotSupportedPermission()
                //case .motion:     return NotSupportedPermission()
                //case .mediaLibrary: return NotSupportedPermission()
                case .bluetooth: return BluetoothPermission()
                //case .tracking:   return NotSupportedPermission()
                default: return NotSupportedPermission()
                }
            }()
        }
        
        return PermissionCache[permission.name] ?? NotSupportedPermission()
    }

}

extension CHPermission {
        
    public var needAddUsageDescription: Bool {
        guard let usageDescriptionKey = usageDescriptionKey else { return false }
        return (Bundle.main.infoDictionary?[usageDescriptionKey] == nil)
    }
    
    public var usageDescriptionKey: String? {
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
    
    public var usageDescriptionText: String {
        guard let key = usageDescriptionKey else { return "" }
        return "Missing info.plist key for '\(key)'"
    }
}
