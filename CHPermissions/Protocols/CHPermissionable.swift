//
//  CHPermissionable.swift
//  Permissions
//
//  Created by kay on 2021/01/20.
//

import Foundation

protocol CHPermissionable {
    
    /// 권한 상태
    var status: CHStatus { get }
        
    /// 권한 요청
    func request(completion: @escaping CHClouser.Void)
}

extension CHPermissionable {
    
    var status: CHStatus { return .error(.notSupportedPermission) }
        
    var isAuthorized: Bool { return self.status == .authorized }
}
