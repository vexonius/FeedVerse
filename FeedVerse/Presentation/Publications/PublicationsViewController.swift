//
//  PublicationsViewController.swift
//  FeedVerse
//
//  Created by Tino Emer on 13.04.2022..
//

import UIKit
import RxSwift
import RxDataSources
import RxEnumKit
import RxCocoa
import Nuke

class PublicationsViewController: BaseViewController, HasCustomView {

    typealias CustomView = PublicationsView

    var viewModel: PublicationsViewModel!

    override func loadView() {
        view = PublicationsView(frame: .zero)
        view.backgroundColor = .gray
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupPublicationsTableView()
        bindViewModel()
    }

    private func setupNavigationBar() {
        navigationItem.title = String.sources
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.edit, style: .done, target: nil, action: nil)
        navigationItem.rightBarButtonItem?.tintColor = .black
    }

    private func setupPublicationsTableView() {
        mainView.publicationsTableView.register(PublicationCell.self, forCellReuseIdentifier: PublicationCell.reuseIdentifier)
        mainView.publicationsTableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.identifier)
        mainView.publicationsTableView.estimatedRowHeight = UITableView.automaticDimension
    }
}

extension PublicationsViewController: BindableType {

    func bindViewModel() {
        viewModel.output.items
            .map { [PublicationSection(header: "", publications: $0)] }
            .bind(to: mainView.publicationsTableView.rx.items(dataSource: datasource))
            .disposed(by: disposeBag)

        mainView.publicationsTableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)

        mainView.publicationsTableView.rx.modelDeleted(Publication.self)
            .bind(to: viewModel.input.itemDeleted)
            .disposed(by: disposeBag)

        // Work in progress
        mainView.addButton.rx.tap
            .withLatestFrom(mainView.addSourceTextField.rx.text.orEmpty.asObservable())
            .bind(to: viewModel.input.addNew)
            .disposed(by: disposeBag)
    }

}

extension PublicationsViewController {

    private var datasource: RxTableViewSectionedAnimatedDataSource <PublicationSection> {
        RxTableViewSectionedAnimatedDataSource<PublicationSection>(
            animationConfiguration: AnimationConfiguration(insertAnimation: .top,
                                                           reloadAnimation: .fade,
                                                           deleteAnimation: .left),
            configureCell: { _, table, _, item in
                guard let cell = table.dequeueReusableCell(withIdentifier: PublicationCell.reuseIdentifier) as? PublicationCell else {
                    return UITableViewCell(style: .default, reuseIdentifier: UITableViewCell.identifier)
                }

                cell.bind(publication: item)
                return cell
            },
            canEditRowAtIndexPath: { _, _ in
                true
            }
        )
    }

}

extension PublicationsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

}
