//
//  String+Ext.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 18.06.2023.
//

import UIKit

extension String {
    public var storyBoard: UIStoryboard {
        UIStoryboard(name: self, bundle: nil)
    }

    public func viewController(identifier: String) -> UIViewController {
        storyBoard.instantiateViewController(withIdentifier: identifier)
    }

    public var initialViewController: UIViewController {
        storyBoard.instantiateInitialViewController()!
    }
}

