//
//  ViewController.swift
//  Permissioner
//
//  Created by kay on 2020/12/14.
//

import Foundation
import UIKit

class PermissionListView: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let permissions: [Permission] = Permission.allCases

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("permissions: \(permissions)")
        
    }
}

extension PermissionListView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return permissions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PermissionListCell", for: indexPath) as! PermissionListCell
        cell.permission = permissions[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        permissions[indexPath.row].request { [weak self] (status) in
            guard let strongSelf = self else { return }
            print("\(strongSelf.permissions[indexPath.row].name) status: \(status)")
            strongSelf.tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}
