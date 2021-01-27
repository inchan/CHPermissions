//
//  BluetoothPermission.swift
//  Permissioner
//
//  Created by kay on 2021/01/18.
//

import Foundation
import CoreBluetooth

class BluetoothPermission: NSObject, PermissionProtocol {
    
    private var manager: CBCentralManager?
    private var completion: Clouser.Completion?

    var status: Status {
        if #available(iOS 13.1, *) {
            let authorization: CBManagerAuthorization = CBCentralManager().authorization
            switch authorization {
            case .notDetermined:
                return .notDetermined
            case .restricted:
                return .restrted
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
                return .restrted
            case .authorized:
                return .authorized
            default:
                return .denied
            }
        }
    }
        
    func request(completion: @escaping Clouser.Completion) {
        self.completion = completion
        self.manager = CBCentralManager(delegate: self, queue: nil, options: [:])
    }
    
}

extension BluetoothPermission: CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        self.completion?(self.status)
    }
}
