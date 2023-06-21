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
}
