//
//  PublicationsUseCaseProvider.swift
//  FeedVerse
//
//  Created by Tino Emer on 13.04.2022..
//

import Foundation
import RxSwift

protocol PublicationsUseCaseProvider {
    func getFeed(for publication: String) -> Observable<Feed>
    func loadPublicationsFromPersistentStorage() -> Observable<[Publication]>
    func savePublication(publication: Publication) -> Completable
    func deletePublication(publication: Publication) -> Completable
}

final class PublicationsUseCase: PublicationsUseCaseProvider {

    private let feedRepository: FeedRepositoryProvider

    init(feedRepository: FeedRepositoryProvider) {
        self.feedRepository = feedRepository
    }

    func getFeed(for publication: String) -> Observable<Feed> {
        feedRepository.fetchRSSFeed(url: publication)
            .asObservable()
    }

    func loadPublicationsFromPersistentStorage() -> Observable<[Publication]> {
        feedRepository.loadFromPersistentStorage(type: Publication.self)
    }

    func savePublication(publication: Publication) -> Completable {
        feedRepository.persist(model: publication)
    }

    func deletePublication(publication: Publication) -> Completable {
        feedRepository.delete(model: publication)
    }

}
