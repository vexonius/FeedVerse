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

    init(feedService: FeedServiceProvider, databaseClient: DatabaseClientProvider) {
        self.feedService = feedService
        self.databaseClient = databaseClient
    }

    func fetchRSSFeed(url: String) -> Single<Feed> {
        feedService.fetchRSSFeed(url: url)
    }

    func loadFromPersistentStorage<T: DBModel>(type _: T.Type) -> Observable<[T]> {
        databaseClient.observeModels(type: T.self)
    }

    func persistAll<T: DBModel>(models: [T]) -> Completable {
        databaseClient.saveAll(models: models)
    }

    func persist<T: DBModel>(model: T) -> Completable {
        databaseClient.save(model: model)
    }

    func delete<T: DBModel>(model: T) -> Completable {
        databaseClient.delete(model: model)
    }

}
