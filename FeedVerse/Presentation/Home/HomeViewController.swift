//
//  ViewController.swift
//  FeedVerse
//
//  Created by Tino Emer on 01.04.2022..
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: BaseViewController, HasCustomView {

    typealias CustomView = HomeView

    override func loadView() {
        view = HomeView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }

}
