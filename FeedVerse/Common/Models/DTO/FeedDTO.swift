//
//  Feed.swift
//  FeedVerse
//
//  Created by Tino Emer on 02.04.2022..
//

import Foundation
import XMLCoder

struct FeedDTO: Decodable {
    let version: String
    let publication: PublicationDTO

    enum CodingKeys: String, CodingKey {
        case version
        case publication = "channel"
    }
}

struct PublicationDTO: Decodable {
    let title: String
    let description: String
    let link: String
    let publicationImage: PublicationImage?
    let articles: [ArticleDTO]

    enum CodingKeys: String, CodingKey {
        case title
        case description
        case link
        case publicationImage = "image"
        case articles = "item"
    }
}

struct PublicationImage: Decodable {
    let url: String?
}

struct ArticleDTO: Decodable {
    let title: String
    let description: String
    let link: String
    let guid: String?
    let categories: [String]
    let date: String?
    let enclosure: Enclosure?
    let mediaContent: MediaContent?

    enum CodingKeys: String, CodingKey {
        case title
        case description
        case link
        case guid
        case categories = "category"
        case date = "pubDate"
        case enclosure = "enclosure"
        case mediaContent = "media:content"
    }
}

struct MediaContent: Decodable {
    let medium: String?
    let url: String?
}

struct Enclosure: Decodable {
    let type: String?
    let url: String?
    let value: String?
}

enum EnclosureTypeDTO: String {
    case jpeg = "image/jpeg"
    case png = "image/png"
    case svg = "image/svg+xml"
    case mp4 = "video/mp4"
    case mpeg = "video/mpeg"
    case mpegAudio = "audio/mpeg"
    case unknown = ""
}
