//
//  ContactsPermission.swift
//  Permissioner
//
//  Created by kay on 2021/01/18.
//

import Foundation
import Contacts

struct ContactsPermission: CHPermissionable {
    
    var status: CHStatus {
        switch CNContactStore.authorizationStatus(for: .contacts) {
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
        CNContactStore().requestAccess(for: .contacts, completionHandler: { (granted, error) in
            completion()
        })
    }
}
