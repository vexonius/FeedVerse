//
//  Publication.swift
//  FeedVerse
//
//  Created by Tino Emer on 13.04.2022..
//

import Foundation
import GRDB
import RxDataSources

struct Publication {
    let id: String
    let title: String
    let description: String
    let link: String
    let imageUrl: String?
    let rssLink: String?

    init(id: String, title: String, description: String, link: String, imageUrl: String, rssLink: String = "") {
        self.id = id
        self.title = title
        self.description = description
        self.link = link
        self.imageUrl = imageUrl
        self.rssLink = rssLink
    }

    init(from dto: PublicationDTO) {
        self.id = dto.link
        self.title = dto.title
        self.description = dto.description
        self.link = dto.link
        self.imageUrl = dto.publicationImage?.url ?? ""
        self.rssLink = ""
    }
}

extension Publication: IdentifiableType, Equatable {
    typealias Identity = Int

    var identity: Int {
        id.hashValue
    }

    static func == (lhs: Publication, rhs: Publication) -> Bool {
        guard lhs.id == rhs.id else {
            return false
        }

        return true
    }
}

extension Publication: FetchableRecord, PersistableRecord, TableRecord {

    enum Columns: String, ColumnExpression {
        case id, title, description, link, imageUrl, rssLink
    }

    init(row: Row) {
        id = row[Columns.id]
        title = row[Columns.title]
        description = row[Columns.description]
        link = row[Columns.link]
        imageUrl = row[Columns.imageUrl]
        rssLink = row[Columns.rssLink]
    }

    func encode(to container: inout PersistenceContainer) {
        container[Columns.id] = id
        container[Columns.title] = title
        container[Columns.description] = description
        container[Columns.link] = link
        container[Columns.imageUrl] = imageUrl
        container[Columns.rssLink] = rssLink
    }

}

extension Publication {
    func addRssLink(url: String) -> Publication {
        Publication(id: id,
                    title: title,
                    description: description,
                    link: link,
                    imageUrl: imageUrl ?? "",
                    rssLink: url)
    }
}
