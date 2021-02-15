//
//  RemindersPermission.swift
//  CHPermissions
//
//  Created by kay on 2021/02/04.
//

import Foundation
import EventKit

struct RemindersPermission: CHPermissionable {
    
    var status: CHStatus {
        switch EKEventStore.authorizationStatus(for: EKEntityType.reminder) {
        case .notDetermined:
            return .notDetermined
        case .restricted:
            return .restricted
        case .denied:
            return .denied
        case .authorized:
            return .authorized
        default:
            return .denied
        }
    }
    
    func request(completion: @escaping CHClouser.Void) {
        EKEventStore().requestAccess(to: EKEntityType.reminder, completion: {
            (accessGranted: Bool, error: Error?) in
            completion()
        })
    }
}
