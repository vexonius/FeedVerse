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

    private(set) lazy var name: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = .systemFont(ofSize: 18, weight: .bold)
        view.numberOfLines = 0
        view.lineBreakMode = .byTruncatingTail
        view.textAlignment = .left
        view.textColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private(set) lazy var thumbNailView: UIImageView = {
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
        setupThumbNail()
        setupTitle()
    }

    private func setupTitle() {
        contentView.addSubview(name)

        name.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview().offset(16)
            make.right.equalTo(thumbNailView.snp.left).offset(-16)
            make.height.greaterThanOrEqualTo(20)
            make.height.lessThanOrEqualTo(68)
        }
    }

    private func setupThumbNail() {
        contentView.addSubview(thumbNailView)

        thumbNailView.snp.makeConstraints { make in
            make.size.equalTo(40)
            make.centerY.equalToSuperview()
            make.rightMargin.equalToSuperview()
        }
    }
}

extension PublicationCell {

    func bind(publication: Publication) {
        self.name.text = publication.title

        if let imagePath = publication.imageUrl, let url = URL(string: imagePath) {
            Nuke.loadImage(with: url, into: self.thumbNailView)
        } else {
            self.thumbNailView.image = UIImage.placeHolder
        }
    }

}
