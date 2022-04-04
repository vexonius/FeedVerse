//
//  FeedService.swift
//  FeedVerse
//
//  Created by Tino Emer on 02.04.2022..
//

import Foundation
import RxSwift
import RxAlamofire
import XMLCoder

protocol FeedServiceProvider {
    func fetchRSSFeed(url: String) -> Single<Feed>
}

final class FeedService: FeedServiceProvider {

    let client: NetworkClientProvider = NetworkClient()

    func fetchRSSFeed(url: String) -> Single<Feed> {
        client.get(path: url, params: [:], headers: [:], encoding: .default, responseType: FeedDTO.self)
            .observe(on: ConcurrentDispatchQueueScheduler.init(queue: .global()))
            .flatMap { [weak self] feedDTO -> Single<Feed> in
                guard let self = self else {
                    return .error(FeedServiceError.unknownError)
                }

                let flattenedFeed = self.flattenFeedDTO(from: feedDTO)

                return .just(flattenedFeed)
            }
    }

    private func flattenFeedDTO(from feedDTO: FeedDTO) -> Feed {
        Feed(
            publication: Publication(from: feedDTO.publication),
             articles: feedDTO.publication.articles.map { Article(from: $0) }
        )
    }

}

enum FeedServiceError: Error {
    case unknownError
}
