//
//  UIViewControllerExtensions.swift
//  Permissions
//
//  Created by kay on 2021/02/03.
//

import UIKit

extension UIViewController {
    
    // 간편 알럿
    func showAlert(title: String = "", message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
