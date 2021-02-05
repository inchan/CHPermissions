//
//  NotSupportedPermission.swift
//  CHPermission
//
//  Created by kay on 2021/02/03.
//

import Foundation

struct NotSupportedPermission: CHPermissionable {

    func request(completion: @escaping CHClouser.Void) {
        completion()
    }
}
