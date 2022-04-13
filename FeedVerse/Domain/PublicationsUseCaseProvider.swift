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

}
