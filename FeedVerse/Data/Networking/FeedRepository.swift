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

    init(feedService: FeedServiceProvider) {
        self.feedService = feedService
    }

    func fetchRSSFeed(url: String) -> Single<Feed> {
        feedService.fetchRSSFeed(url: url)
    }

}
