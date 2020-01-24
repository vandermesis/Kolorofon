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
        //  Show lauch screen for 0.5 sec to display logo
        Thread.sleep(forTimeInterval: 0.5) // Never seen that kind of logic here, but It could be smarter to add subview of launchscreen to your game controller
        // This gives you a possibility to do animations and stuff, it always looks nice when you see launchscreen and then it nicely dissappears :)

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
