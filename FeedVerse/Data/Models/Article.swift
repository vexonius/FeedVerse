//
//  Article.swift
//  FeedVerse
//
//  Created by Tino Emer on 13.04.2022..
//

import Foundation
import RxDataSources
import GRDB

struct Article {
    let id: String
    let title: String
    let description: String
    let coverUrl: String?
    let link: String
    let date: String?

    init(from dto: ArticleDTO) {
        self.id = dto.guid ?? dto.link
        self.title = dto.title
        self.description = dto.description
        self.coverUrl = dto.enclosure?.url ?? dto.mediaContent?.url
        self.link = dto.link
        self.date = dto.date
    }

    init (id: String, title: String, description: String, coverUrl: String, link: String, date: String) {
        self.id = id
        self.title = title
        self.description = description
        self.coverUrl = coverUrl
        self.link = link
        self.date = date
    }
}

extension Article: IdentifiableType, Equatable {
    typealias Identity = Int

    var identity: Int {
        id.hashValue
    }

    static func == (lhs: Article, rhs: Article) -> Bool {
        guard lhs.id == rhs.id else {
            return false
        }

        return true
    }
}

extension Article: FetchableRecord, PersistableRecord, TableRecord {

    enum Columns: String, ColumnExpression {
            case id, title, description, link, coverUrl, date
        }

    init(row: Row) {
        id = row[Columns.id]
        title = row[Columns.title]
        description = row[Columns.description]
        link = row[Columns.link]
        coverUrl = row[Columns.coverUrl]
        date = row[Columns.date]
    }

    func encode(to container: inout PersistenceContainer) {
        container[Columns.id] = id
        container[Columns.title] = title
        container[Columns.description] = description
        container[Columns.link] = link
        container[Columns.coverUrl] = coverUrl
        container[Columns.date] = date
    }

}
