//
//  FeedUseCase.swift
//  FeedVerse
//
//  Created by Tino Emer on 12.04.2022..
//

import Foundation
import RxSwift

protocol FeedUseCaseProvider {
    func getFeed() -> Single<Feed>
}

final class FeedUsecase: FeedUseCaseProvider {

    private let feedRepository: FeedRepositoryProvider

    init(feedRepository: FeedRepositoryProvider) {
        self.feedRepository = feedRepository
    }

    func getFeed() -> Single<Feed> {
        feedRepository.fetchRSSFeed(url: "https:bug.hr/rss")
    }

}
