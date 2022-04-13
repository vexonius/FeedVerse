//
//  FeedRepositoryProvider.swift
//  FeedVerse
//
//  Created by Tino Emer on 12.04.2022..
//

import Foundation
import RxSwift

protocol FeedRepositoryProvider {
    func fetchRSSFeed(url: String) -> Single<Feed>
    func saveFeed(feed: Feed) -> Completable
    func loadFromPersistentStorage<T: DBModel>(type _: T.Type) -> Observable<[T]>
}
