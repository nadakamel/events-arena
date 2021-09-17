//
//  AppDelegate.swift
//  Events Arena
//
//  Created by Nada Kamel on 16/09/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        ThemeManager.configure()
        AppWindowManager.setupWindow()
        return true
    }
    
}
