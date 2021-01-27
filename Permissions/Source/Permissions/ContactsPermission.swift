//
//  ContactsPermission.swift
//  Permissioner
//
//  Created by kay on 2021/01/18.
//

import Foundation
import Contacts

class ContactsPermission: NSObject, PermissionProtocol {
    
    var didChangedStatus: Clouser.Completion?
    
    private var _status: Status? {
        didSet {
            if let _status = _status {
                didChangedStatus?(_status)
            }
        }
    }
    
    var status: Status {
        let status: Status = {
            let Status = CNContactStore.authorizationStatus(for: .contacts)
            switch Status {
            case .notDetermined:
                return .notDetermined
            case .restricted:
                return .restrted
            case.denied:
                return .denied
            case .authorized:
                return .authorized
            @unknown default:
                return .denied
            }
        }()
        self._status = status
        return status
    }
    
    func request(completion: @escaping Clouser.Completion) {
        CNContactStore().requestAccess(for: .contacts, completionHandler: { (granted, error) in
            self.finishRequest(completion: completion)
        })
    }
}
