//
//  Publication.swift
//  FeedVerse
//
//  Created by Tino Emer on 13.04.2022..
//

import Foundation
import GRDB

struct Publication {
    let id: String
    let title: String
    let description: String
    let link: String
    let imageUrl: String

    init(id: String, title: String, description: String, link: String, imageUrl: String) {
        self.id = id
        self.title = title
        self.description = description
        self.link = link
        self.imageUrl = imageUrl
    }

    init(from dto: PublicationDTO) {
        self.id = dto.link
        self.title = dto.title
        self.description = dto.description
        self.link = dto.link
        self.imageUrl = dto.publicationImage?.url ?? ""
    }
}

extension Publication: Equatable {

    static func == (lhs: Publication, rhs: Publication) -> Bool {
        guard lhs.id == rhs.id else {
            return false
        }

        return true
    }
}

extension Publication: FetchableRecord, PersistableRecord, TableRecord {

    enum Columns: String, ColumnExpression {
            case id, title, description, link, imageUrl
        }

    init(row: Row) {
        id = row[Columns.id]
        title = row[Columns.title]
        description = row[Columns.description]
        link = row[Columns.link]
        imageUrl = row[Columns.imageUrl]
    }

    func encode(to container: inout PersistenceContainer) {
        container[Columns.id] = id
        container[Columns.title] = title
        container[Columns.description] = description
        container[Columns.link] = link
        container[Columns.imageUrl] = imageUrl
    }

}
