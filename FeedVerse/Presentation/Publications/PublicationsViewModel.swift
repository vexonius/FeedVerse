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
}

protocol PublicationViewModelOutput {
    var items: BehaviorRelay<[Publication]> { get }
}

extension PublicationsViewModel {
    var input: PublicationViewModelInput { self }
    var output: PublicationViewModelOutput { self }
}

class PublicationsViewModel: BaseViewModel, PublicationViewModelInput, PublicationViewModelOutput {

    private(set) var items: BehaviorRelay<[Publication]> = BehaviorRelay(value: [])
    private(set) var itemDeleted: PublishSubject<Publication> = PublishSubject()

}
