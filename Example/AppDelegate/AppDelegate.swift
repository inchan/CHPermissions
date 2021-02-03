//
//  AppDelegate.swift
//  Permissioner
//
//  Created by kay on 2020/12/14.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
//        UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
//            print("error: \(error)")
//            print("granted: \(granted)")
//            //DispatchQueue.main.async(execute: { [weak self] in
//                //guard let strongSelf = self else { return }
//                //print("strongSelf.status: \(strongSelf.status)")
//                //completion(strongSelf.status)
//            //})
//        }
//
        return true
    }

}

