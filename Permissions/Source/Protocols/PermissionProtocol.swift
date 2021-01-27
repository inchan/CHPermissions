//
//  PermissionProtocol.swift
//  Permissions
//
//  Created by kay on 2021/01/20.
//

import Foundation

protocol PermissionProtocol: class, Identifiable {
    
    /// 권한 상태
    var status: Status { get }
        
    /// 권한 요청
    func request(completion: @escaping Clouser.Completion)
}

extension PermissionProtocol {
    
    var status: Status { return .error(.notSupportedPermission) }
    
    func request(completion: @escaping Clouser.Completion) {
        finishRequest(completion: completion)
    }

    func finishRequest(completion: @escaping Clouser.Completion) {
        if Thread.isMainThread == true {
            completion(self.status)
        }
        else {
            DispatchQueue.main.async(execute: { [weak self] in
                guard let strongSelf = self else { return }
                completion(strongSelf.status)
            })
        }
    }
}
