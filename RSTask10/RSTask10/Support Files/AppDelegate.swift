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
    var coordinator: Coordinator!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        setupAppearence()
        
        let coordinator = Coordinator(window: window)
        coordinator.start()
        
        window.makeKeyAndVisible()
        return true
    }
    

    func setupAppearence(){
        let navigationBarAppearence = UINavigationBar.appearance()
        navigationBarAppearence.largeTitleTextAttributes = [.font : UIFont(name: "Nunito-ExtraBold", size: 36)!, .foregroundColor: UIColor.white]
        navigationBarAppearence.barTintColor = UIColor(named: "AppBackground")
        navigationBarAppearence.backgroundColor = UIColor(named: "AppBackground")
        navigationBarAppearence.setBackgroundImage(UIImage(), for: .default)
        navigationBarAppearence.shadowImage = UIImage()
        
        let barButtonItemAppearence = UIBarButtonItem.appearance()
        barButtonItemAppearence.setTitleTextAttributes([.font: UIFont(name: "Nunito-ExtraBold", size: 17)!, .foregroundColor: UIColor(named: "AppJade")!], for: .normal)
        barButtonItemAppearence.setTitleTextAttributes([.font: UIFont(name: "Nunito-ExtraBold", size: 17)!, .foregroundColor: UIColor.white], for: .highlighted)
        barButtonItemAppearence.setTitleTextAttributes([.font: UIFont(name: "Nunito-ExtraBold", size: 17)!], for: .disabled)
    }
    
}
