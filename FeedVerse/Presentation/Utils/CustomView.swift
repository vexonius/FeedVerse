//
//  CustomView.swift
//  FeedVerse
//
//  Created by Tino Emer on 05.04.2022..
//

import Foundation
import UIKit

public protocol HasCustomView {
    associatedtype CustomView: UIView
}

public extension HasCustomView where Self: UIViewController {
    var mainView: CustomView {
        guard let mainView = view as? CustomView else {
            fatalError("Expected view to be of type \(CustomView.self) but got \(type(of: view)) instead")
        }
        return mainView
    }
}
