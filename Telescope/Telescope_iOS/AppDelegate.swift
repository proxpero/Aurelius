//
//  AppDelegate.swift
//  Telescope_iOS
//
//  Created by Todd Olsen on 1/11/17.
//
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        if let window = window {
            appCoordinator = AppCoordinator(window: window)
        }
        return true
    }

}

