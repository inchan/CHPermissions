//
//  CHPermissions.swift
//  CHPermissions
//
//  Created by kay on 2021/02/04.
//

import Foundation

public struct CHPermissions {
    
    /// 퍼미션 리스트
    public static let list: [CHPermission] = CHPermission.allCases
    
    public static func check(permission: CHPermission, completion: @escaping CHClouser.Completion) {
        completion(permission.status)
    }
}
