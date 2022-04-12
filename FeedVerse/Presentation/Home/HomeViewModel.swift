//
//  HomeViewModel.swift
//  FeedVerse
//
//  Created by Tino Emer on 07.04.2022..
//

import Foundation
import RxRelay
import RxSwift
import EnumKit
import RxCocoa

protocol HomeViewModelInput {
}

protocol HomeViewModelOutput {
    var state: BehaviorRelay<HomeViewModel.State> { get }
}

class HomeViewModel: BaseViewModel, HomeViewModelInput, HomeViewModelOutput {

    enum State: CaseAccessible {
        case loading
        case loaded(feed: [Article])
        case refreshing
        case loadedWithError(feed: Feed, error: Error)
        case error
    }

    private(set) var state: BehaviorRelay<State> = BehaviorRelay(value: .loading)

    private let feedService: FeedServiceProvider = FeedService()

    override init() {

        state.accept(.loading)
        super.init()

        feedService.fetchRSSFeed(url: "https://bug.hr/rss")
            .debug()
            .subscribe(
                onSuccess: { [weak self] rss in
                    self?.state.accept(.loaded(feed: rss.articles))
                },
                onFailure: { [weak self] error in
                    self?.state.accept(.error)
                }
            )
            .disposed(by: disposeBag)
    }

}
