//
//  CHError.swift
//  Permissioner
//
//  Created by kay on 2021/01/20.
//

import Foundation

public enum CHError: Error {
    case unknow
    case notSupportedPermission
    case needToUsageDescription(_ description: String)
}

extension CHError: CustomDebugStringConvertible {
    
    public var description: String {
        return debugDescription
    }
    
    public var debugDescription: String {
        switch self {
        case .unknow:
            return "unknow"
        case .notSupportedPermission:
            return "not supported permission"
        case .needToUsageDescription(let description):
            return description
        }
    }
}
