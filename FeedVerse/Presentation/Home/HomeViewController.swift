//
//  ViewController.swift
//  FeedVerse
//
//  Created by Tino Emer on 01.04.2022..
//

import UIKit
import RxSwift
import RxDataSources
import RxEnumKit
import RxCocoa
import Nuke

class HomeViewController: BaseViewController, HasCustomView {

    typealias CustomView = HomeView

    var viewModel: HomeViewModel!

    override func loadView() {
        view = HomeView(frame: .zero)
        view.backgroundColor = .white
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupFeedTableView()
        bindViewModel()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }

    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.feedSettings, style: .done, target: nil, action: nil)
        navigationItem.rightBarButtonItem?.tintColor = .black
    }

    private func setupFeedTableView() {
        mainView.articlesTableView.register(ArticleCell.self, forCellReuseIdentifier: ArticleCell.reuseIdentifier)
        mainView.articlesTableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.identifier)
        mainView.articlesTableView.estimatedRowHeight = UITableView.automaticDimension
    }
}

extension HomeViewController: BindableType {

    func bindViewModel() {

        viewModel.state.asDriver()
            .map(case: HomeViewModel.State.loaded, [Article].init)
            .map { [ArticleSection(header: String.tableViewHeader, articles: $0)] }
            .drive(mainView.articlesTableView.rx.items(dataSource: datasource))
            .disposed(by: disposeBag)

        mainView.articlesTableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)

        viewModel.state
            .map { $0.isNotMatching(case: .loading) ? false : true }
            .bind(to: mainView.refreshControl.rx.isRefreshing)
            .disposed(by: disposeBag)

    }

}

extension HomeViewController {

    private var datasource: RxTableViewSectionedAnimatedDataSource <ArticleSection> {
        RxTableViewSectionedAnimatedDataSource<ArticleSection>(
            animationConfiguration: AnimationConfiguration(insertAnimation: .top,
                                                           reloadAnimation: .fade,
                                                           deleteAnimation: .left),
            configureCell: { _, table, _, item in
                guard let cell = table.dequeueReusableCell(withIdentifier: ArticleCell.reuseIdentifier) as? ArticleCell else {
                    return UITableViewCell(style: .default, reuseIdentifier: UITableViewCell.identifier)
                }

                cell.bind(article: item)
                return cell
            },
            canEditRowAtIndexPath: { _, _ in
                true
            }
        )
    }

}

extension HomeViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

}
