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
import UIKit

protocol HomeViewModelInput {
    var refreshTrigger: PublishSubject<Void> { get }
}

protocol HomeViewModelOutput {
    var state: BehaviorRelay<HomeViewModel.State> { get }
}

extension HomeViewModel {
    var input: HomeViewModelInput { self }
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
    private(set) var refreshTrigger: PublishSubject<Void>

    private let articlesUseCase: ArticlesUseCaseProvider
    private let publicationsUseCase: PublicationsUseCaseProvider
    private let scheduler = ConcurrentDispatchQueueScheduler(queue: .global(qos: .default))

    init(articlesUseCase: ArticlesUseCaseProvider, publicationsUseCase: PublicationsUseCase) {
        self.articlesUseCase = articlesUseCase
        self.publicationsUseCase = publicationsUseCase

        state.accept(.loading)
        self.refreshTrigger = PublishSubject()

        super.init()

        articlesUseCase.loadFromPersistentStorage()
            .observe(on: scheduler)
            .subscribe(onNext: { articles in
                self.state.accept(.loaded(feed: articles))
            })
            .disposed(by: disposeBag)

        publicationsUseCase.loadPublicationsFromPersistentStorage()
            .observe(on: scheduler)
            .subscribe(onNext: { publications in
                debugPrint(publications)
            })
            .disposed(by: disposeBag)

        refreshTrigger.subscribe(onNext: {
            self.state.accept(.refreshing)
        })
        .disposed(by: disposeBag)

    }

}
