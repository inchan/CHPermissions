//
//  PermissionError.swift
//  Permissioner
//
//  Created by kay on 2021/01/20.
//

import Foundation

enum PermissionError: Error {
    
    case unknow
    case notSupportedPermission
    case needToUsageDescription(_ description: String)
}

extension PermissionError: CustomDebugStringConvertible {
    
    var description: String {
        return debugDescription
    }
    
    var debugDescription: String {
        switch self {
        case .needToUsageDescription(let description):
            return description
        default:
            return "\(self)"
        }
    }
}
