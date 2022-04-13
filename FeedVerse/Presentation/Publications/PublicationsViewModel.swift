//
//  PublicationsViewModel.swift
//  FeedVerse
//
//  Created by Tino Emer on 13.04.2022..
//

import Foundation
import RxSwift
import RxCocoa

protocol PublicationViewModelInput {
    var itemDeleted: PublishSubject<Publication> { get }
    var addNew: PublishSubject<String> { get }
}

protocol PublicationViewModelOutput {
    var items: BehaviorRelay<[Publication]> { get }
    var errorDispatcher: PublishSubject<PublicationError> { get }
}

extension PublicationsViewModel {
    var input: PublicationViewModelInput { self }
    var output: PublicationViewModelOutput { self }
}

class PublicationsViewModel: BaseViewModel, PublicationViewModelInput, PublicationViewModelOutput {

    private(set) var items: BehaviorRelay<[Publication]> = BehaviorRelay(value: [])
    private(set) var itemDeleted: PublishSubject<Publication> = PublishSubject()
    private(set) var addNew: PublishSubject<String> = PublishSubject()
    private(set) var errorDispatcher: PublishSubject<PublicationError> = PublishSubject()

    private let coordinator: AppCoordinatorProvider
    private let publicationsUseCase: PublicationsUseCaseProvider

    init(publicationsUseCase: PublicationsUseCaseProvider, coordinator: AppCoordinatorProvider) {
        self.publicationsUseCase = publicationsUseCase
        self.coordinator = coordinator
        super.init()

        publicationsUseCase.loadPublicationsFromPersistentStorage()
            .withUnretained(self)
            .debug()
            .subscribe(onNext: { owner, items in
                debugPrint(items)
                owner.items.accept(items)
            })
            .disposed(by: disposeBag)

        addNew
            .withUnretained(self)
            .flatMap { owner, url -> Observable<Feed> in
                owner.publicationsUseCase.getFeed(for: url)
            }
            .materialize()
            .flatMap({ [weak self] event -> Observable<Never> in
                if let element = event.element {
                    return publicationsUseCase.savePublication(publication: element.publication).andThen(.never())
                } else {
                    debugPrint(event.error)
                    self?.errorDispatcher.onNext(PublicationError.parsingError(message: "Unsupported format. Please use RSS 2.0 source."))
                }
                return .never()
            })
            .subscribe()
            .disposed(by: disposeBag)

        itemDeleted
            .withUnretained(self)
            .flatMap({ owner, item -> Observable<Publication> in
                owner.publicationsUseCase.deletePublication(publication: item).andThen(Observable<Publication>.never())

            })
            .subscribe()
            .disposed(by: disposeBag)
    }

}

enum PublicationError: Error {
    case notValidUrl(message: String)
    case parsingError(message: String)
}
