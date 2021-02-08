//
//  PermissionCell.swift
//  CHPermissions_Example
//
//  Created by kay on 2021/02/08.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import CHPermissions

class PermissionCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    var permission: CHPermission? {
        didSet {
            guard let permission = permission else { return }
            titleLabel.text = permission.name
            switch permission.status {
            case .error(let error):
                statusLabel.text = "\(error)"
            default:
                statusLabel.text = "\(permission.status)"
            }
        }
    }
}

