//
//  LoginViewController.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 28.06.2023.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: BaseViewController<LoginViewModel> {

    @IBOutlet private weak var topImageView: UIImageView!
    @IBOutlet private weak var mainStackView: UIStackView!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var signUpButton: UIButton!
    @IBOutlet private weak var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func setViewModel() {
        viewModel = LoginViewModel()
    }

    private func setupUI() {
        emailTextField.layer.borderWidth = 2
        emailTextField.layer.borderColor = UIColor.white.cgColor
        emailTextField.layer.cornerRadius = 20

        passwordTextField.layer.borderWidth = 2
        passwordTextField.layer.borderColor = UIColor.white.cgColor
        passwordTextField.layer.cornerRadius = 20

        loginButton.layer.cornerRadius = 20
    }

    @IBAction func loginButtonTapped(_ sender: UIButton) {
        print("login")
    }

    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        print("signUp")
    }
}
