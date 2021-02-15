//
//  BluetoothPermission.swift
//  Permissioner
//
//  Created by kay on 2021/01/18.
//

import Foundation
import CoreBluetooth

class BluetoothPermission: NSObject, CHPermissionable {
    
    private var manager: CBCentralManager?
    private var completion: CHClouser.Void?

    var status: CHStatus {
        if #available(iOS 13.1, *) {
            switch CBCentralManager.authorization {
            case .notDetermined:
                return .notDetermined
            case .restricted:
                return .restricted
            case .allowedAlways:
                return .authorized
            default:
                return .denied
            }
        } else {
            switch CBPeripheralManager.authorizationStatus() {
            case .notDetermined:
                return .notDetermined
            case .restricted:
                return .restricted
            case .authorized:
                return .authorized
            default:
                return .denied
            }
        }
    }
        
    func request(completion: @escaping CHClouser.Void) {
        self.completion = completion
        self.manager = CBCentralManager(delegate: self, queue: nil, options: [:])
    }
    
}

extension BluetoothPermission: CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        self.completion?()
    }
}
