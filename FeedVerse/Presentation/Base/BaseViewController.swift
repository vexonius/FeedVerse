//
//  BaseViewController.swift
//  FeedVerse
//
//  Created by Tino Emer on 05.04.2022..
//

import Foundation
import UIKit
import RxSwift

class BaseViewController: UIViewController {
    let disposeBag = DisposeBag()

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
