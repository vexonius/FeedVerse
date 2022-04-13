//
//  AppCoordinator.swift
//  FeedVerse
//
//  Created by Tino Emer on 13.04.2022..
//

import Foundation
import UIKit
import SafariServices

protocol AppCoordinatorProvider {
    var navigationController: UINavigationController { get set }

    func begin()
    func openExternalLink(link: String)
    func routeToPublications()
}

final class AppCoordinator: AppCoordinatorProvider {

    var navigationController: UINavigationController
    private let DIContainer: AppDIContainer

    init(navigationController: UINavigationController, DIContainer: AppDIContainer) {
          self.navigationController = navigationController
        self.DIContainer = DIContainer
      }

    func begin() {
        let homeViewController: UIViewController = DIContainer.createHomeViewController(coordinator: self)
        navigationController.pushViewController(homeViewController, animated: true)
    }

    func openExternalLink(link: String) {
        guard let url = URL(string: link) else { return }
        let safariViewController = SFSafariViewController(url: url)
        navigationController.present(safariViewController, animated: true)
    }

    func routeToPublications() {
        let publicationsViewController: UIViewController = DIContainer.createPublicationsViewController(coordinator: self)
        navigationController.present(UINavigationController(rootViewController: publicationsViewController), animated: true)
    }

}
