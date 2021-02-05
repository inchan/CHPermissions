//
//  SpeechPermission.swift
//  CHPermissions
//
//  Created by kay on 2021/02/04.
//

import Foundation
import Speech

struct SpeechPermission: CHPermissionable {
    
    var status: CHStatus {
        switch SFSpeechRecognizer.authorizationStatus() {
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
    
    func request(completion: @escaping CHClouser.Void) {
        SFSpeechRecognizer.requestAuthorization { status in
            completion()
        }
    }
}
