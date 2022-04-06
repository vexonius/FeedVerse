//
//  ArticleSectionModel.swift
//  FeedVerse
//
//  Created by Tino Emer on 05.04.2022..
//

import Foundation
import RxDataSources

struct ArticleSection {
    var header: String
    var articles: [Article]

    init(header: String, articles: [Article]) {
        self.header = header
        self.articles = articles
    }
}

extension ArticleSection: AnimatableSectionModelType {

    typealias Item = Article
    typealias Identity = String

    var identity: String {
        header
    }

    var items: [Article] {
        articles
    }

    init(original: ArticleSection, items: [Item]) {
        self = original
        self.articles = items
    }
}
