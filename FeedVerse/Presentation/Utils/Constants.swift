//
//  Images+Constants.swift
//  FeedVerse
//
//  Created by Tino Emer on 07.04.2022..
//

import Foundation
import UIKit

extension UIImage {
    static let logo = UIImage(named: "logo")
    static let feedSettings = UIImage(named: "feed-settings")
    static let flyingRocket = UIImage(named: "rocket-flying")
    static let placeHolder = UIImage(named: "placeholder")
    static let edit = UIImage(named: "pen")
}

extension UIColor {
    static let accent = UIColor(named: "accent-color")
    static let primaryText = UIColor(named: "primaryText")
    static let secondaryText = UIColor(named: "secondaryText")
    static let lightBackground = UIColor(named: "light-grey")
}

extension String {
    static let tableViewHeader = "Feed"
    static let error = "Something went wrong... Our ship crashed!"
    static let emptyPlaceholer = "Nothing to see here"
    static let loading = "Loading"
    static let inputHint = "Add RSS source"
    static let inputPlaceholder = "https://bug.hr/rss..."
    static let sources = "Sources"
    static let delete = "Delete"
    static let add = "Add"
    static let appName = "FeedVerse"

}
