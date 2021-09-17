//
//  ThemeManager.swift
//  Events Arena
//
//  Created by Nada Kamel on 16/09/2021.
//

import UIKit

enum ThemeManager {
    static let backgroundColor = UIColor(red: 31.0/255.0, green: 33.0/255.0, blue: 36.0/255.0, alpha: 1.0)
    
    static let pinkColor = UIColor(red: 216.0/255.0, green: 46.0/255.0, blue: 137.0/255.0, alpha: 1.0)
    
    static let greenColor = UIColor(red: 150.0/255.0, green: 211.0/255.0, blue: 95.0/255.0, alpha: 1.0)
    
    static let blueColor = UIColor(red: 0.0, green: 199.0/255.0, blue: 252.0/255.0, alpha: 1.0)
    
    static let orangeColor = UIColor(red: 1.0, green: 147.0/255.0, blue: 0.0, alpha: 1.0)
    
    static func configure() {
        // MARK: - UIApperance
        configureNavigationBarAppearance()
    }
}

//MARK: - UINavigationBar Appearance
private extension ThemeManager {
    static func configureNavigationBarAppearance() {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().backgroundColor = .clear
        UINavigationBar.appearance().tintColor = .white
    }
}
