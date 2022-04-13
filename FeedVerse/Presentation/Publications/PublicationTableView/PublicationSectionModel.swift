//
//  PublicationSectionModel.swift
//  FeedVerse
//
//  Created by Tino Emer on 13.04.2022..
//

import Foundation
import RxDataSources

struct PublicationSection {
    var header: String
    var publications: [Publication]

    init(header: String, publications: [Publication]) {
        self.header = header
        self.publications = publications
    }
}

extension PublicationSection: AnimatableSectionModelType {

    typealias Item = Publication
    typealias Identity = String

    var identity: String {
        header
    }

    var items: [Publication] {
        publications
    }

    init(original: PublicationSection, items: [Item]) {
        self = original
        self.publications = items
    }
}
