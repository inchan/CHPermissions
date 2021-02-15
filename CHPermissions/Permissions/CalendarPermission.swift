//
//  CalendarPermission.swift
//  Permissions
//
//  Created by kay on 2021/02/03.
//

import Foundation
import EventKit

struct CalendarPermission: CHPermissionable {
    
    var status: CHStatus {
        switch EKEventStore.authorizationStatus(for: EKEntityType.event) {
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
        EKEventStore().requestAccess(to: EKEntityType.event, completion: {
            (accessGranted: Bool, error: Error?) in
            completion()
        })
    }
}
