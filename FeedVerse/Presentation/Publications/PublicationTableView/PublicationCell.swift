//
//  PublicationCell.swift
//  FeedVerse
//
//  Created by Tino Emer on 13.04.2022..
//

import Foundation
import UIKit
import SnapKit
import Nuke

class PublicationCell: UITableViewCell {

    public static let reuseIdentifier = "PublicationCellID"

    private(set) lazy var publicationName: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = .systemFont(ofSize: 16, weight: .bold)
        view.numberOfLines = 1
        view.lineBreakMode = .byTruncatingTail
        view.textAlignment = .left
        view.textColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private(set) lazy var thumbNailView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.sizeToFit()
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
        setupThumbNail()
        setupTitle()
    }

    private func setupTitle() {
        contentView.addSubview(publicationName)

        publicationName.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(layoutMarginsGuide.snp.left)
            make.right.equalTo(thumbNailView.snp.left)
            make.height.greaterThanOrEqualTo(60)
            make.height.lessThanOrEqualTo(80)
            make.centerY.equalToSuperview()
        }
    }

    private func setupThumbNail() {
        contentView.addSubview(thumbNailView)

        thumbNailView.snp.makeConstraints { make in
            make.size.equalTo(40)
            make.centerY.equalToSuperview()
            make.right.equalTo(layoutMarginsGuide.snp.right)
        }

        thumbNailView.layer.cornerRadius = 20

    }
}

extension PublicationCell {

    func bind(publication: Publication) {
        self.publicationName.text = publication.title

        if let imagePath = publication.imageUrl, let url = URL(string: imagePath) {
            Nuke.loadImage(with: url, options: Nuke.ImageLoadingOptions.shared, into: self.thumbNailView)
        } else {
            self.thumbNailView.image = UIImage.placeHolder
        }
    }

}
