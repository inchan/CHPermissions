//
//  PermissionListViewController.swift
//  CHPermissions
//
//  Created by enliple-kay on 02/08/2021.
//  Copyright (c) 2021 enliple-kay. All rights reserved.
//

import UIKit
import CHPermissions

class PermissionListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let permissions: [CHPermission] = CHPermissions.list

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
}

extension PermissionListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return permissions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PermissionCell", for: indexPath) as! PermissionCell
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

extension UIViewController {
    
    // 간편 알럿
    func showAlert(title: String = "", message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
