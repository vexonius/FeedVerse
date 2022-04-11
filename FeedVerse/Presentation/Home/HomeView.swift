//
//  HomeView.swift
//  FeedVerse
//
//  Created by Tino Emer on 05.04.2022..
//

import Foundation
import UIKit

final class HomeView: UIView {

    private(set) lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        let imageView = UIImageView(image: UIImage.logo)
        imageView.sizeToFit()
        refreshControl.addSubview(imageView)
        return refreshControl
    }()

    private(set) lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()

    private(set) lazy var articlesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.contentInset.bottom = 20
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContainerView()
        setupTableView()
        setupRefreshControll()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupContainerView() {
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func setupTableView() {
        containerView.addSubview(articlesTableView)
        articlesTableView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.left.right.bottom.equalToSuperview()
        }
    }

    private func setupRefreshControll() {
        refreshControl.subviews.first?.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.height.equalTo(50)
            make.center.equalToSuperview()
        }

        articlesTableView.addSubview(refreshControl)
    }

}
