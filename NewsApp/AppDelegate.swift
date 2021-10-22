//
//  AppDelegate.swift
//  NewsApp
//
//  Created by Sabina Huseynova on 24.09.21.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: MainCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let navController = UINavigationController()
        
            coordinator = MainCoordinator(navigationController: navController)
            coordinator?.start()

            window = UIWindow(frame: UIScreen.main.bounds)
            window?.rootViewController = navController
            window?.makeKeyAndVisible()

        
        return true
    }
}

    
