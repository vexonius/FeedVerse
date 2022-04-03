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

    func fetchRSSFeed(url: String) -> Single<Feed> {
        RxAlamofire.requestData(.get, url)
            .debug()
            .asSingle()
            .flatMap { (response, data) -> Single<Feed> in
                guard let feed = try? XMLDecoder().decode(Feed.self, from: data) else {
                    return .error(FeedServiceError.parsingError)
                }

                return .just(feed)
            }
    }

}

enum FeedServiceError: Error {
    case parsingError
}
