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
        client.get(path: url, params: [:], headers: [:], encoding: .default, responseType: Feed.self)
            .flatMap { feed -> Single<Feed> in
                return .just(feed)
            }
    }

}
