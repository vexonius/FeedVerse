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
    func persistAll<T: DBModel>(models: [T]) -> Completable
    func persist<T: DBModel>(model: T) -> Completable
    func delete<T: DBModel>(model: T) -> Completable
    func loadFromPersistentStorage<T: DBModel>(type _: T.Type) -> Observable<[T]>
}
