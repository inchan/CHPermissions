//
//  MicrophonePermission.swift
//  Permissions
//
//  Created by kay on 2021/02/03.
//

import Foundation
import AVFoundation

struct MicrophonePermission: CHPermissionable {
    
    var status: CHStatus {
//        switch AVAudioSession.sharedInstance().recordPermission {
//        case .undetermined:
//            return .notDetermined
//        case .granted:
//            return .authorized
//        case .denied:
//            return .denied
//        @unknown default:
//            return .denied
//        }
        return .denied
    }
    
    func request(completion: @escaping CHClouser.Void) {
        AVAudioSession.sharedInstance().requestRecordPermission {
            granted in
            DispatchQueue.main.async {
                completion()
            }
        }
    }
}
