//
//  ViewController.swift
//  Permissioner
//
//  Created by kay on 2020/12/14.
//

import Foundation
import UIKit
import CHPermissions

class PermissionListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let permissions: [CHPermission] = CHPermission.allCases

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let permission: CHPermission = .notification
        let status = permission.status
        print("\(permission) status: \(status)")

        // or
        let isAuthorized = status.isAuthorized
        print("\(permission) isAuthorized: \(isAuthorized)")

    }
}

extension PermissionListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return permissions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PermissionListCell", for: indexPath) as! PermissionListCell
        let permission = permissions[indexPath.row]
        cell.permission = permission
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let permission = permissions[indexPath.row]
        permission.request { [weak self] (status) in
            
            print("\(permission) request complete: \(status)")

            guard let strongSelf = self else { return }
            
            switch status {
            case .error(let CHError):
                strongSelf.showAlert(title: "Permission Error", message: CHError.debugDescription)
            default:
                strongSelf.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
    }
}

