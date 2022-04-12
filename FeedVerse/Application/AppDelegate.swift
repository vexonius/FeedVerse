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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        let viewController = HomeViewController()
        let feedService: FeedServiceProvider = FeedService()
        let feedRepository: FeedRepositoryProvider = FeedRepository(feedService: feedService)
        let useCase: FeedUseCaseProvider = FeedUsecase(feedRepository: feedRepository)
        
        viewController.viewModel = HomeViewModel(feedUseCase: useCase)
        let navigationController = UINavigationController(rootViewController: viewController)

        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        setupImageLoadingOptions()

        return true
    }

}
