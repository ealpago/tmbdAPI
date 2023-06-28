//
//  SignUpViewController.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 29.06.2023.
//

import UIKit

class SignUpViewController: BaseViewController<SignUpViewModel> {

    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle()
        changeNavigationBar(navigationBackgroundColor: .clear, font: UIFont())
    }

    override func setViewModel() {
        viewModel = SignUpViewModel()
    }

}
