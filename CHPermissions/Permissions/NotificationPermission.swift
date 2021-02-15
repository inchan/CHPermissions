//
//  NotificationPermission.swift
//  Permissions
//
//  Created by kay on 2021/01/20.
//

import Foundation
import UIKit
import UserNotifications

struct NotificationPermission: CHPermissionable {
        
    var status: CHStatus {
        guard let notificationStatus = fetchNotificationStatus() else {
            return .denied
        }
        switch notificationStatus {
        case .notDetermined: return .notDetermined
        case .authorized: return .authorized
        default:
            if #available(iOS 12.0, *) { // ERROR here
                if notificationStatus == .provisional {
                    return .restricted
                }
            }
            
            if #available(iOS 14.0, *) { // ERROR here
                if notificationStatus == .ephemeral {
                    return .restricted
                }
            }
            
            return .denied
        }
    }
    
    func request(completion: @escaping CHClouser.Void) {
        if #available(iOS 10.0, tvOS 10.0, *) {
            UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
                completion()
            }
        } else {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
            completion()
        }
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    private func fetchNotificationStatus() -> UNAuthorizationStatus? {
        var NotificationSettings: UNNotificationSettings?
        let semaphore = DispatchSemaphore(value: 0)
        
        DispatchQueue.global().async {
            UNUserNotificationCenter.current().getNotificationSettings { setttings in
                NotificationSettings = setttings
                semaphore.signal()
            }
        }
        
        semaphore.wait()
        return NotificationSettings?.authorizationStatus
    }
}
