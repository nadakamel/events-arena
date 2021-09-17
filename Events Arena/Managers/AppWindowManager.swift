//
//  AppWindowManager.swift
//  Events Arena
//
//  Created by Nada Kamel on 16/09/2021.
//

import UIKit

enum AppWindowManager {
    static func setupWindow() {
        let window = self.window ?? UIWindow.init(frame: windowFrame)
        
        let homeViewController = HomeViewController()
        homeViewController.title = "Events"
        let navigationController = UINavigationController(rootViewController:  homeViewController)
        window.rootViewController = navigationController
        
        self.window = window
        window.makeKeyAndVisible()
    }
}

private extension AppWindowManager {
    static var window: UIWindow? {
        get {
            return (UIApplication.shared.delegate as? AppDelegate)?.window
        }
        set {
            (UIApplication.shared.delegate as? AppDelegate)?.window = newValue
        }
    }

    static var windowFrame: CGRect {
        return UIScreen.main.bounds
    }
}
