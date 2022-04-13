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
    var publicationRouteTrigger: PublishSubject<Void> { get }
    var selectedItem: PublishSubject<Article> { get }
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
    private(set) var publicationRouteTrigger: PublishSubject<Void>
    private(set) var selectedItem: PublishSubject<Article>

    private let articlesUseCase: ArticlesUseCaseProvider
    private let publicationsUseCase: PublicationsUseCaseProvider
    private let coordinator: AppCoordinatorProvider
    private let scheduler = ConcurrentDispatchQueueScheduler(queue: .global(qos: .default))

    init(articlesUseCase: ArticlesUseCaseProvider, publicationsUseCase: PublicationsUseCaseProvider, coordinator: AppCoordinatorProvider) {
        self.articlesUseCase = articlesUseCase
        self.publicationsUseCase = publicationsUseCase
        self.coordinator = coordinator

        state.accept(.loading)
        self.refreshTrigger = PublishSubject()
        self.publicationRouteTrigger = PublishSubject()
        self.selectedItem = PublishSubject()

        super.init()

        articlesUseCase.loadFromPersistentStorage()
            .observe(on: scheduler)
            .distinctUntilChanged()
            .subscribe(onNext: { articles in
                self.state.accept(.loaded(feed: articles))
            })
            .disposed(by: disposeBag)

        publicationsUseCase.loadPublicationsFromPersistentStorage()
            .observe(on: scheduler)
            .distinctUntilChanged()
            .withUnretained(self)
            .flatMap({ owner, publications in
                owner.articlesUseCase.getFeed(for: publications.map { $0.rssLink! }).asObservable()
            })
            .subscribe()
            .disposed(by: disposeBag)

        refreshTrigger
            .withLatestFrom(publicationsUseCase.loadPublicationsFromPersistentStorage())
            .withUnretained(self)
            .flatMap { owner, publications -> Observable<Never> in
                owner.articlesUseCase.getFeed(for: publications.map { $0.rssLink! })
            }
            .subscribe(onNext: { [weak self] _ in
                self?.state.accept(.refreshing)
            })
            .disposed(by: disposeBag)

        selectedItem
            .withUnretained(self)
            .subscribe(onNext: { owner, article in
                owner.coordinator.openExternalLink(link: article.link)
            })
            .disposed(by: disposeBag)

        publicationRouteTrigger
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.coordinator.routeToPublications()
            })
            .disposed(by: disposeBag)
    }

}
