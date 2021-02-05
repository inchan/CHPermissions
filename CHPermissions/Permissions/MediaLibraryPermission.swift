//
//  MediaLibraryPermission.swift
//  CHPermissions
//
//  Created by kay on 2021/02/05.
//

import Foundation
import MediaPlayer

struct MediaLibraryPermission: CHPermissionable {
        
    var status: CHStatus {
        switch MPMediaLibrary.authorizationStatus() {
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
        MPMediaLibrary.requestAuthorization() { _ in
            completion()
        }
    }
}
