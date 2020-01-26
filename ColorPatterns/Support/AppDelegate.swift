//
//  AppDelegate.swift
//  ColorPatterns
//
//  Created by Administrator on 29.04.2019.
//  Copyright © 2019 vandermesis. All rights reserved.
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let startingController = setupStartingController()
        displayStartingController(controller: startingController)
        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        SettingsBundleHelper.setVersionAndBuildNumber()
    }

}

private extension AppDelegate {

    private func setupStartingController() -> UIViewController {
        let controller = StartMenuCreator().getController()
        return controller
    }

    private func displayStartingController(controller: UIViewController) {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
    }
}
