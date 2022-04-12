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
}
