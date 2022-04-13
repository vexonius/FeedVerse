//
//  PublicationsView.swift
//  FeedVerse
//
//  Created by Tino Emer on 13.04.2022..
//

import Foundation
import UIKit
import SnapKit

class PublicationsView: UIView {

    private(set) lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()

    private(set) lazy var publicationsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInset.bottom = 20
        return tableView
    }()

    private(set) lazy var addSourceHintLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .left
        label.textColor = .black
        label.text = String.inputHint
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private(set) lazy var addSourceTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.font = .systemFont(ofSize: 16, weight: .regular)
        textField.placeholder = String.inputPlaceholder
        textField.textAlignment = .left
        textField.textColor = .black
        textField.backgroundColor = UIColor.lightBackground
        textField.layer.cornerRadius = 20
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 48))
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private(set) lazy var addButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.black
        button.setTitle(String.add, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 20
        return button

    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContainerView()
        setupHintLabel()
        setupAddButton()
        setupTableView()
        setupSourceInput()
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

    private func setupAddButton() {
        containerView.addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.top.equalTo(addSourceHintLabel.snp.bottom)
            make.right.equalTo(layoutMarginsGuide.snp.right)
            make.height.equalTo(48)
            make.width.equalTo(100)
        }
    }

    private func setupSourceInput() {
        containerView.addSubview(addSourceTextField)
        addSourceTextField.snp.makeConstraints { make in
            make.top.equalTo(addSourceHintLabel.snp.bottom)
            make.left.equalTo(layoutMarginsGuide.snp.left)
            make.height.equalTo(48)
            make.right.equalTo(addButton.snp.left).offset(-16)
        }
    }

    private func setupHintLabel() {
        containerView.addSubview(addSourceHintLabel)
        addSourceHintLabel.snp.makeConstraints { make in
            make.top.equalTo(layoutMarginsGuide.snp.top)
            make.left.equalTo(layoutMarginsGuide.snp.left)
            make.height.equalTo(40)
            make.right.equalToSuperview().offset(-16)
        }
    }

    private func setupTableView() {
        containerView.addSubview(publicationsTableView)
        publicationsTableView.snp.makeConstraints { make in
            make.top.equalTo(addButton.snp.bottom).offset(16)
            make.left.right.bottom.equalToSuperview()
        }
    }

}
