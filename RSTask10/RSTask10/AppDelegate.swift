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
        setupAppearence()
        let navigationController = UINavigationController()
        navigationController.viewControllers = [DashboardViewController(), NewPlayerViewController()]
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        return true
    }
    

    func setupAppearence(){
        let navigationBarAppearence = UINavigationBar.appearance()
        navigationBarAppearence.largeTitleTextAttributes = [.font : UIFont(name: "Nunito-ExtraBold", size: 36)!, .foregroundColor: UIColor.white]
        
        let barButtonItemAppearence = UIBarButtonItem.appearance()
        barButtonItemAppearence.setTitleTextAttributes([.font: UIFont(name: "Nunito-ExtraBold", size: 17)!, .foregroundColor: UIColor(named: "AppJade")!], for: .normal)
        barButtonItemAppearence.setTitleTextAttributes([.font: UIFont(name: "Nunito-ExtraBold", size: 17)!, .foregroundColor: UIColor.white], for: .highlighted)
        barButtonItemAppearence.setTitleTextAttributes([.font: UIFont(name: "Nunito-ExtraBold", size: 17)!], for: .disabled)
    }
    
}
