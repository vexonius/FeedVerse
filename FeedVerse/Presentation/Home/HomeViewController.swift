//
//  ViewController.swift
//  FeedVerse
//
//  Created by Tino Emer on 01.04.2022..
//

import UIKit
import RxSwift
import RxDataSources
import Nuke

class HomeViewController: BaseViewController, HasCustomView {

    typealias CustomView = HomeView

    override func loadView() {
        view = HomeView(frame: .zero)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.mainView.backgroundColor = .white

        mainView.articlesTableView.rowHeight = UITableView.automaticDimension
        mainView.articlesTableView.estimatedRowHeight = UITableView.automaticDimension

        mainView.articlesTableView.rowHeight = UITableView.automaticDimension
        mainView.articlesTableView.estimatedRowHeight = 140

        mainView.articlesTableView.register(ArticleCell.self, forCellReuseIdentifier: ArticleCell.reuseIdentifier)
        mainView.articlesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "emptyCell")



    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
}

extension HomeViewController {

    var datasource: RxTableViewSectionedAnimatedDataSource <ArticleSection> {
        RxTableViewSectionedAnimatedDataSource<ArticleSection>(
            animationConfiguration: AnimationConfiguration(insertAnimation: .top,
                                                           reloadAnimation: .fade,
                                                           deleteAnimation: .left),
            configureCell: { _, table, _, item in
                guard let cell = table.dequeueReusableCell(withIdentifier: ArticleCell.reuseIdentifier) as? ArticleCell else {
                    return UITableViewCell(style: .default, reuseIdentifier: "emptyCell")
                }

                cell.titleView.text = item.title
                cell.descriptionView.text = item.description

                if let imageUrl = item.coverUrl, let url = URL(string: imageUrl) {
                    Nuke.loadImage(with: url, into: cell.coverView)
                }

                return cell
            }
        )
    }

}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
