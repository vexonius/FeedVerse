//
//  HomeView.swift
//  FeedVerse
//
//  Created by Tino Emer on 05.04.2022..
//

import Foundation
import UIKit

final class HomeView: UIView {

    private(set) lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    private(set) lazy var articlesTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.register(ArticleCell.self, forCellReuseIdentifier: ArticleCell.reuseIdentifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "emptyCell")
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
