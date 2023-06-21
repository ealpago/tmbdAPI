//
//  BaseViewController.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 21.06.2023.
//

import UIKit

open class BaseViewController<T:BaseViewModel>: UIViewController, BaseViewModelProtocol {

    public var viewModel: T!

    open override func viewDidLoad() {
        setViewModel()
        super.viewDidLoad()
        self.viewModel.delegate = self
    }

    open func setViewModel() {

    }

    open func changeNavigationBar(navigationBackgroundColor: UIColor, font: UIFont, textColor: UIColor = .white) {
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = navigationBackgroundColor
            appearance.titleTextAttributes = [NSAttributedString.Key.font: font, .foregroundColor: textColor]
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        } else {
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: UIBarMetrics.defaultPrompt)
            navigationController?.navigationBar.shadowImage = UIImage()
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: font, .foregroundColor: textColor]
            navigationController?.navigationBar.barTintColor = navigationBackgroundColor
            navigationController?.navigationBar.isTranslucent = false
        }
    }
}
