//
//  PermissionListCell.swift
//  Permissions
//
//  Created by kay on 2021/01/20.
//

import Foundation
import UIKit
import CHPermissions

class PermissionListCell: UITableViewCell {
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

