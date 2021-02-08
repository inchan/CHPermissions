//
//  MotionPermission.swift
//  CHPermissions
//
//  Created by kay on 2021/02/04.
//

import Foundation
import CoreMotion

struct MotionPermission: CHPermissionable {
    
    var status: CHStatus {
        if #available(iOS 11.0, *) {
            switch CMMotionActivityManager.authorizationStatus() {
            case .notDetermined:
                return .notDetermined
            case .restricted:
                return .restricted
            case .denied:
                return .denied
            case .authorized:
                return .authorized
            @unknown default:
                return .denied
            }
        }
        return .notDetermined
    }
    
    func request(completion: @escaping CHClouser.Void) {
        let manager = CMMotionActivityManager()
        let today = Date()
        manager.queryActivityStarting(from: today, to: today, to: OperationQueue.main, withHandler: { (_, _) -> () in
            completion()
            manager.stopActivityUpdates()
        })
    }
    
}
