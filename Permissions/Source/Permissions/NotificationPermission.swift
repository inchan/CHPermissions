//
//  NotificationPermission.swift
//  Permissions
//
//  Created by kay on 2021/01/20.
//

import Foundation
import UIKit
import UserNotifications

class NotificationPermission: NSObject, PermissionProtocol {
    
    var status: Status {
        switch fetchNotificationStatus() {
        case .notDetermined: return .notDetermined
        case .authorized: return .authorized
        case .provisional, .ephemeral: return .restrted
        default: return .denied
        }
    }
    
    func request(completion: @escaping Clouser.Completion) {
        if #available(iOS 10.0, tvOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
                DispatchQueue.main.async(execute: { [weak self] in
                    guard let strongSelf = self else { return }
                    completion(strongSelf.status)
                })
            }
        } else {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
            DispatchQueue.main.async(execute: { [weak self] in
                guard let strongSelf = self else { return }
                completion(strongSelf.status)
            })
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
