//
//  CameraPermission.swift
//  Permissions
//
//  Created by kay on 2021/02/03.
//

import Foundation
import AVFoundation

struct CameraPermission: CHPermissionable {
    
    var status: CHStatus {
        switch AVCaptureDevice.authorizationStatus(for: AVMediaType.video) {
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
        AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: {
            finished in
            completion()
        })
    }
}
