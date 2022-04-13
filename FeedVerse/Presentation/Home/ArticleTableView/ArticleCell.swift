//
//  ArticleCell.swift
//  FeedVerse
//
//  Created by Tino Emer on 05.04.2022..
//

import Foundation
import UIKit
import SnapKit
import Nuke

class ArticleCell: UITableViewCell {

    public static let reuseIdentifier = "ArticleCellID"

    private(set) lazy var titleView: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = .systemFont(ofSize: 18, weight: .bold)
        view.numberOfLines = 0
        view.lineBreakMode = .byTruncatingTail
        view.textAlignment = .left
        view.textColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private(set) lazy var descriptionView: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 14, weight: .regular)
        view.numberOfLines = 0
        view.lineBreakMode = .byTruncatingTail
        view.textAlignment = .left
        view.textColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private(set) lazy var coverView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 40
        view.clipsToBounds = true
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .white
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        setupCover()
        setupTitle()
        setupDescription()
    }

    private func setupTitle() {
        contentView.addSubview(titleView)

        titleView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().inset(18)
            make.right.equalTo(coverView.snp.left).offset(-18)
            make.height.greaterThanOrEqualTo(20)
            make.height.lessThanOrEqualTo(68)
        }
    }

    private func setupCover() {
        contentView.addSubview(coverView)

        coverView.snp.makeConstraints { make in
            make.size.equalTo(80)
            make.centerY.equalToSuperview()
            make.rightMargin.equalToSuperview()
        }

    }

    private func setupDescription() {
        contentView.addSubview(descriptionView)

        descriptionView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(18)
            make.top.equalTo(titleView.snp.bottom).offset(4)
            make.right.equalTo(coverView.snp.left).offset(-18)
            make.bottom.equalToSuperview().offset(-16)
            make.height.greaterThanOrEqualTo(20)
            make.height.lessThanOrEqualTo(60)
        }
    }

}

extension ArticleCell {

    func bind(article: Article) {
        self.titleView.text = article.title
        self.descriptionView.text = article.description

        if let imagePath = article.coverUrl, let url = URL(string: imagePath) {
            Nuke.loadImage(with: url, into: self.coverView)
        } else {
            self.coverView.image = UIImage.placeHolder
        }

    }

}
