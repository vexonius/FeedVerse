//
//  FeedUseCase.swift
//  FeedVerse
//
//  Created by Tino Emer on 12.04.2022..
//

import Foundation
import RxSwift

protocol ArticlesUseCaseProvider {
    var errorDispatcher: PublishSubject<Error> { get }
    func getFeed(for sources: [String]) -> Observable<Never>
    func loadFromPersistentStorage() -> Observable<[Article]>
}

final class ArticlesUseCase: ArticlesUseCaseProvider {

    private let feedRepository: FeedRepositoryProvider
    private(set) var errorDispatcher: PublishSubject<Error>

    init(feedRepository: FeedRepositoryProvider) {
        self.feedRepository = feedRepository
        errorDispatcher = PublishSubject()
    }

    func getFeed(for sources: [String]) -> Observable<Never> {
        Observable.from(sources)
            .withUnretained(self)
            .flatMap { owner, url -> Observable<Feed> in
                owner.feedRepository.fetchRSSFeed(url: url).asObservable()
            }
            .materialize()
            .flatMap { event -> Observable<Never> in
                guard let element = event.element else { return .never() }

                return self.feedRepository.saveFeed(feed: element).andThen(.never())
            }
    }

    func loadFromPersistentStorage() -> Observable<[Article]> {
        feedRepository.loadFromPersistentStorage(type: Article.self)
    }

}
