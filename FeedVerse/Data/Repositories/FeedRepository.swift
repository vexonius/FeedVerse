//
//  FeedRepository.swift
//  FeedVerse
//
//  Created by Tino Emer on 12.04.2022..
//

import Foundation
import RxSwift

final class FeedRepository: FeedRepositoryProvider {

    private let feedService: FeedServiceProvider
    private let databaseClient: DatabaseClientProvider

    init(feedService: FeedServiceProvider, databaseClient: DatabaseClient) {
        self.feedService = feedService
        self.databaseClient = databaseClient
    }

    func fetchRSSFeed(url: String) -> Single<Feed> {
        feedService.fetchRSSFeed(url: url)
    }

    func loadFromPersistentStorage<T: DBModel>(type _: T.Type) -> Observable<[T]> {
        databaseClient.observeModels(type: T.self)
    }

    func saveFeed(feed: Feed) -> Completable {
        databaseClient.saveAll(models: feed.articles)
    }

}
