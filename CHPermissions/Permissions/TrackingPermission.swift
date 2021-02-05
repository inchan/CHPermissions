//
//  TrackingPermission.swift
//  CHPermissions
//
//  Created by kay on 2021/02/05.
//

import Foundation
import AppTrackingTransparency

struct TrackingPermission: CHPermissionable {
    
    
    var status: CHStatus {
        if #available(iOS 14.0, *) {
            switch ATTrackingManager.trackingAuthorizationStatus {
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
        return .authorized
    }
    
    func request(completion: @escaping CHClouser.Void) {
        if #available(iOS 14.0, *) {
            ATTrackingManager.requestTrackingAuthorization { _ in
                completion()
            }
        }
        else {
            completion()
        }
        
    }
}
