//
//  Feed.swift
//  FeedVerse
//
//  Created by Tino Emer on 02.04.2022..
//

import Foundation
import XMLCoder


struct Feed: Decodable {
    let version: String?
    let publication: Publication

    enum CodingKeys: String, CodingKey {
        case version
        case publication = "channel"
    }
}

struct Publication: Decodable {
    let title: String
    let description: String
    let publicationImage: PublicationImage?
    let articles: [Article]

    enum CodingKeys: String, CodingKey {
        case title
        case description
        case publicationImage = "image"
        case articles = "item"
    }
}

struct PublicationImage: Decodable {
    let url: String?
}

struct Article: Decodable {
    let title: String
    let description: String
    let link: String?
    let guid: String?
    let categories: [String]
    let pubDate: String?
    let enclosure: Enclosure?
}

struct Enclosure: Decodable {
    let type: String?
    let url: String?
    let value: String?
}

enum EnclosureType: String {
    case jpeg = "image/jpeg"
    case png = "image/png"
    case unknown = ""
}
