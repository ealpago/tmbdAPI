//
//  SignUpViewController.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 29.06.2023.
//

import UIKit
import Firebase
import FirebaseAuth


class SignUpViewController: BaseViewController<SignUpViewModel> {

    @IBOutlet private weak var nameView: TextFieldView!
    @IBOutlet private weak var surnameView: TextFieldView!
    @IBOutlet private weak var mailView: TextFieldView!
    @IBOutlet private weak var passwordView: TextFieldView!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var movieIconImageView: UIImageView!
    @IBOutlet private weak var signUpLabel: UILabel!
    @IBOutlet private weak var mainStackView: UIStackView!
    @IBOutlet private weak var registerButton: UIButton!

    private var name: String?
    private var surname: String?
    private var email: String?
    private var password: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle()
        changeNavigationBar(navigationBackgroundColor: .clear, font: UIFont())
        setupUI()
    }

    override func setViewModel() {
        viewModel = SignUpViewModel()
    }

    private func setupUI() {
        nameView.registerSection = .name
        nameView.textFieldDidEnd = { text in
            self.setButtonEnable()
            self.name = text
        }
        surnameView.registerSection = .surname
        surnameView.textFieldDidEnd = { text in
            self.setButtonEnable()
            self.surname = text
        }
        mailView.registerSection = .email
        mailView.textFieldDidEnd = { text in
            self.setButtonEnable()
            self.email = text
        }
        passwordView.registerSection = .password
        passwordView.textField.isSecureTextEntry = true
        passwordView.textFieldDidEnd = { text in
            self.setButtonEnable()
            self.password = text
        }
        registerButton.layer.cornerRadius = 20
        registerButton.isEnabled = false
        self.scrollView.keyboardDismissMode = .onDrag
        setButtonEnable()
    }

    func registerEmailAndPassword() {
        if let email = email, let password = password {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error?.localizedDescription {
                    print(error)
                    self.showAlert(title: "Uyarı", message: error, canSignUp: false)
                } else {
                    print("Kayıt Başarılı")
                    self.showAlert(title: "Kayıt Yapıldı", message: "Giriş ekranına yönlendiriliyorsunuz", canSignUp: true)
                }
            }
        }
    }

    func showAlert(title: String?, message: String?, canSignUp: Bool?) {

        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        // Create the actions
        let errorAction = UIAlertAction(title: "OK", style: .default) {
            UIAlertAction in
            NSLog("error ok Pressed")
        }
        let doneAction = UIAlertAction(title: "OK", style: .default) {
            UIAlertAction in
            self.navigationController?.popToRootViewController(animated: true)
            NSLog("done ok Pressed")
        }

        // Add the actions
        canSignUp == true ? alertController.addAction(doneAction) : alertController.addAction(errorAction)

        // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }

    private func setButtonEnable() {
        DispatchQueue.main.async {
            self.registerButton.isEnabled = self.checkInformation()
        }
    }

    private func checkInformation() -> Bool {
        var result: Bool = true
        result = result && isValidName(nameView.textField.text ?? "")
        result = result && isValidName(surnameView.textField.text ?? "")
        result = result && isValidEmail(mailView.textField.text ?? "")
        result = result && isValidPassword(passwordView.textField.text ?? "")

        return result
    }

    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        registerEmailAndPassword()
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
}

enum RegisterCases: CaseIterable {
case name
case surname
case email
case password

    var placeholder: String {
        switch self {
        case .name:
            return "Adınız"
        case .surname:
            return "Soyadınız"
        case .email:
            return "E-Mail"
        case .password:
            return "Şifre"
        }
    }

    var error: String {
        switch self {
        case .name, .surname:
            return "Sadece harf girişi olabilir"
        case .email:
            return "Geçersiz mail adresi"
        case .password:
            return "Şifre en az 6 karakter içermelidir"
        }
    }
}
