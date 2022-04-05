//
//  ArticleCell.swift
//  FeedVerse
//
//  Created by Tino Emer on 05.04.2022..
//

import Foundation
import UIKit
import SnapKit

class ArticleCell: UITableViewCell {

    public static let reuseIdentifier = "ArticleCellID"

    lazy var titleView: UILabel = {
        let title = UILabel()
        title.font = .systemFont(ofSize: 18, weight: .bold)
        title.numberOfLines = 2
        title.lineBreakMode = .byWordWrapping
        title.textAlignment = .left
        title.textColor = .black
        return title
    }()

    lazy var descriptionView: UILabel = {
        let title = UILabel()
        title.font = .systemFont(ofSize: 18, weight: .bold)
        title.numberOfLines = 2
        title.lineBreakMode = .byWordWrapping
        title.textAlignment = .left
        title.textColor = .black
        return title
    }()

    lazy var coverView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
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
            make.left.top.equalToSuperview().inset(16)
            make.right.equalTo(coverView.snp.left)
            make.height.equalTo(44)
        }
    }

    private func setupCover() {
        contentView.addSubview(coverView)

        coverView.snp.makeConstraints { make in
            make.width.equalTo(60)
            make.height.equalTo(60)
            make.top.right.equalToSuperview().inset(16)
        }
    }

    private func setupDescription() {
        contentView.addSubview(descriptionView)

        descriptionView.snp.makeConstraints { make in
            make.left.top.equalTo(titleView).inset(16)
            make.right.equalTo(coverView.snp.left)
            make.height.equalTo(30)
        }
    }

}
