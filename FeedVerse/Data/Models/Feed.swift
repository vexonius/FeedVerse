//
//  Feed.swift
//  FeedVerse
//
//  Created by Tino Emer on 04.04.2022..
//

import Foundation
import RxDataSources

struct Feed {
    let publication: Publication
    let articles: [Article]
}

struct Publication {
    let id: String
    let title: String
    let description: String
    let link: String
    let imageUrl: String?

    init(from dto: PublicationDTO) {
        self.id = dto.link
        self.title = dto.title
        self.description = dto.description
        self.link = dto.link
        self.imageUrl = dto.publicationImage?.url
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

struct Article {
    let id: String
    let title: String
    let description: String
    let coverUrl: String?
    let link: String
    let date: String?
    var categories: [String]
    var savedIn: UserPreference = .none

    init(from dto: ArticleDTO) {
        self.id = dto.guid ?? dto.link
        self.title = dto.title
        self.description = dto.description
        self.coverUrl = dto.enclosure?.url ?? dto.mediaContent?.url
        self.link = dto.link
        self.date = dto.date
        self.categories = []
        self.categories.append(contentsOf: dto.categories)
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

enum UserPreference: String, Equatable {
    case favorite
    case archive
    case none

    static func == (lhs: UserPreference, rhs: UserPreference) -> Bool {
        switch (lhs, rhs) {
        case (.favorite, .favorite):
            return true
        case (.archive, .archive):
            return true
        case (.none, .none):
            return true
        default:
            return false
        }
    }
}
