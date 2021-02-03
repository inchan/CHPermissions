//
//  PhotoLibraryPermission.swift
//  Permissions
//
//  Created by kay on 2021/02/03.
//

import Foundation
import Photos

struct PhotoLibraryPermission: CHPermissionable {
    
    var status: CHStatus {
        switch PHPhotoLibrary.authorizationStatus() {
        case .notDetermined:
            return .notDetermined
        case .restricted:
            return .restricted
        case .denied:
            return .denied
        case .authorized, .limited:
            return .authorized
        @unknown default:
            return .denied
        }
    }
    
    func request(completion: @escaping CHClouser.Void) {
        PHPhotoLibrary.requestAuthorization({
            finished in
            DispatchQueue.main.async {
                completion()
            }
        })
    }
}
