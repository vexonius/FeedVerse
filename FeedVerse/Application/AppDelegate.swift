//
//  AppDelegate.swift
//  FeedVerse
//
//  Created by Tino Emer on 01.04.2022..
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinatorProvider?
    let appDIContainer = AppDIContainer()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        self.window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()
        window?.rootViewController = navigationController

        appCoordinator = AppCoordinator(navigationController: navigationController, DIContainer: appDIContainer)
        appCoordinator?.begin()

        window?.makeKeyAndVisible()

        setupImageLoadingOptions()

        return true
    }

}
