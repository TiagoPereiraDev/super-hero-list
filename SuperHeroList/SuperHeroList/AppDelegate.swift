//
//  AppDelegate.swift
//  SuperHeroList
//
//  Created by Tiago Pereira on 28/09/2020.
//  Copyright © 2020 Tiago Pereira. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var rootCoordinator: CharactersListCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        rootCoordinator = CharactersListCoordinator(window: window)
        rootCoordinator?.start()
        
        return true
    }
}

