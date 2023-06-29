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
    @IBOutlet private weak var emailView: TextFieldView!
    @IBOutlet private weak var passwordView: TextFieldView!
    @IBOutlet private weak var buttonsStackView: UIStackView!
    @IBOutlet private weak var signUpButton: UIButton!
    @IBOutlet private weak var loginButton: UIButton!

    private var email: String?
    private var password: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func setViewModel() {
        viewModel = LoginViewModel()
    }

    private func setupUI() {
        emailView.loginSection = .email
        passwordView.loginSection = .password
        loginButton.layer.cornerRadius = 20
    }

    @IBAction func loginButtonTapped(_ sender: UIButton) {
        print("login")
    }

    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        print("signUp")
        if let vc = "SignUpStoryboard".viewController(identifier: SignUpViewController.identifier) as? SignUpViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    func loginEmailAndPassword() {
        if let email = email, let password = password {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in

            }
        }
    }

    @objc func emailDidEnd(_ textField: UITextField) {
        if let text = textField.text {
            if isValidEmail(text) {
                print("true")
            } else {
                print("false")
            }
        }
    }
}

enum LoginCases: CaseIterable {
case email
case password

    var placeholder: String {
        switch self {
        case .email:
            return "E-Mail"
        case .password:
            return "Şifre"
        }
    }

    var error: String {
        switch self {
        case .email:
            return "Geçersiz mail adresi"
        case .password:
            return "Şifre en az 6 karakter içermelidir"
        }
    }
}

