//
//  Feed.swift
//  FeedVerse
//
//  Created by Tino Emer on 04.04.2022..
//

import Foundation
import CryptoKit

struct Feed {
    let publication: Publication
    let articles: [Article]
}

struct Publication: Hashable {

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

    static func == (lhs: Publication, rhs: Publication) -> Bool {
        guard lhs.id == rhs.id else {
            return false
        }

        return true
    }
}

struct Article: Hashable {

    let id: String
    let title: String
    let description: String
    let coverUrl: String?
    let date: String?
    var categories: [String]
    var savedIn: UserPreference = .none

    init(from dto: ArticleDTO) {
        self.id = dto.guid ?? dto.link
        self.title = dto.title
        self.description = dto.description
        self.coverUrl = dto.enclosure?.url ?? dto.mediaContent?.url
        self.date = dto.date
        self.categories = []
        self.categories.append(contentsOf: dto.categories)
    }

    enum UserPreference: String, Equatable {
        case favorite
        case archive
        case none
    }

    static func == (lhs: Article, rhs: Article) -> Bool {
        guard lhs.id == rhs.id else {
            return false
        }

        return true
    }

}
