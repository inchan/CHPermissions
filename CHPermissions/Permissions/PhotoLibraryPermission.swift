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
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .notDetermined:
            return .notDetermined
        case .restricted:
            return .restricted
        case .denied:
            return .denied
        case .authorized:
            return .authorized
        default:
            if #available(iOS 14.0, *) {
                if status == PHAuthorizationStatus.limited {
                    return .authorized
                }
            }
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
