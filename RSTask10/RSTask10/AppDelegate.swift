//
//  AppDelegate.swift
//  RSTask10
//
//  Created by Ivan Budovich on 8/25/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        let navigationController = UINavigationController(rootViewController: DashboardViewController())
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        return true
    }
    

}
