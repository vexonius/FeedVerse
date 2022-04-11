//
//  BindableType.swift
//  FeedVerse
//
//  Created by Tino Emer on 07.04.2022..
//

import Foundation
import RxSwift
import UIKit

protocol BindableType: AnyObject {
    associatedtype ViewModelType

    var viewModel: ViewModelType! { get set }

    func bindViewModel()
}

extension BindableType where Self: UIViewController {
    func bind(to model: Self.ViewModelType) {
        viewModel = model
        loadViewIfNeeded()
        bindViewModel()
    }
}
