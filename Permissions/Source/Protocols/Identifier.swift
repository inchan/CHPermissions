//
//  Identifier.swift
//  Permissioner
//
//  Created by kay on 2021/01/18.
//

import Foundation

protocol Identifiable {
    var appBundleIdentifier: String { get }
    var className: String { get }
    var identifier: String { get }
}

extension Identifiable {
    
    var appBundleIdentifier: String {
        Bundle.main.bundleIdentifier ?? "com.inchan.Permissioner"
    }
    
    var className: String {
        return String(describing: self)
    }

    var identifier: String {
        return appBundleIdentifier + "." + className
    }
}
