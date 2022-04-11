//
//  AppDelegate+Nuke.swift
//  FeedVerse
//
//  Created by Tino Emer on 06.04.2022..
//

import Foundation
import Nuke
import UIKit

extension AppDelegate {
    func setupImageLoadingOptions() {
        Nuke.ImageLoadingOptions.shared.placeholder = UIImage(named: "placeholder")
        Nuke.ImageLoadingOptions.shared.transition = .fadeIn(duration: 0.4)
    }
}
