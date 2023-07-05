//
//  LoginViewController.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 28.06.2023.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseFirestore
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

    override func viewWillDisappear(_ animated: Bool) {
        clearTextField()
    }

    override func setViewModel() {
        viewModel = LoginViewModel()
    }

    private func setupUI() {
        emailView.loginSection = .email
        passwordView.loginSection = .password
        loginButton.layer.cornerRadius = 20
        setButtonEnable()
        emailView.textField.autocorrectionType = .no
        passwordView.textField.isSecureTextEntry = true

        emailView.textFieldDidEnd = { text in
            self.email = text
            self.setButtonEnable()
        }
        passwordView.textFieldDidEnd = { text in
            self.password = text
            self.setButtonEnable()
        }
    }

    private func clearTextField() {
        emailView.textField.text = ""
        passwordView.textField.text = ""
    }

    private func setButtonEnable() {
        DispatchQueue.main.async {
            self.loginButton.isEnabled = self.checkInformation()
        }
    }

    private func checkInformation() -> Bool {
        var result: Bool = true
        result = result && isValidEmail(emailView.textField.text ?? "")
        result = result && isValidPassword(passwordView.textField.text ?? "")

        return result
    }

    @IBAction func loginButtonTapped(_ sender: UIButton) {
        self.startLoading()
        print("login")
        if let email = email, let password = password {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    print(error.localizedDescription)
                    self.showAlert(title: "Uyarı", message: error.localizedDescription)
                } else {
                    if let vc = "BaseTabbarStoryboard".viewController(identifier: BaseTabBarController.identifier) as? BaseTabBarController {
                        UserDefaults.user = email
                        vc.navigationItem.setHidesBackButton(true, animated: true)
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }
        }
        self.stopLoading()
    }

    func showAlert(title: String?, message: String?) {

        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        // Create the actions
        let errorAction = UIAlertAction(title: "OK", style: .default) {
            UIAlertAction in
            NSLog("error ok Pressed")
        }

        // Add the actions
        alertController.addAction(errorAction)

        // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }

    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        print("signUp")
        if let vc = "SignUpStoryboard".viewController(identifier: SignUpViewController.identifier) as? SignUpViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    func loginEmailAndPassword() {
        if let email = email, let password = password {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in }
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

