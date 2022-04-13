//
//  AppDIContainer.swift
//  FeedVerse
//
//  Created by Tino Emer on 13.04.2022..
//

import Foundation
import UIKit

protocol AppDIContainerProvider {
    func createHomeViewController(coordinator: AppCoordinatorProvider) -> UIViewController
}

final class AppDIContainer {
    // App doesn't work without db instance, throw is therefore omitted
    private lazy var database: DatabaseClientProvider! = try! DatabaseClient()

    private lazy var feedService: FeedService = {
        let networkClient = NetworkClient.shared
        return FeedService(client: networkClient)
    }()

    private lazy var feedRepository: FeedRepositoryProvider = {
        let repository = FeedRepository(feedService: feedService, databaseClient: database)
        return repository
    }()
}

extension AppDIContainer: AppDIContainerProvider {

    func createHomeViewController(coordinator: AppCoordinatorProvider) -> UIViewController {
        let articlesUseCase: ArticlesUseCaseProvider = createArticlesUseCase()
        let publicationUseCase: PublicationsUseCaseProvider = createPublicationsUseCase()
        let homeViewModel: HomeViewModel = HomeViewModel(articlesUseCase: articlesUseCase, publicationsUseCase: publicationUseCase, coordinator: coordinator)

        let viewController = HomeViewController()
        viewController.viewModel = homeViewModel

        return viewController
    }
}

extension AppDIContainer {

    private func createArticlesUseCase() -> ArticlesUseCase {
        ArticlesUseCase(feedRepository: feedRepository)
    }

    private func createPublicationsUseCase() -> PublicationsUseCase {
        PublicationsUseCase(feedRepository: feedRepository)
    }

}
