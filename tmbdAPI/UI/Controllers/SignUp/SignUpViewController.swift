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
    
    private var email: String?
    private var password: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle()
        changeNavigationBar(navigationBackgroundColor: .clear, font: UIFont())
        nameView.registerSection = .name
        surnameView.registerSection = .surname
        mailView.registerSection = .email
        passwordView.registerSection = .password
        self.scrollView.keyboardDismissMode = .onDrag
    }
    
    override func setViewModel() {
        viewModel = SignUpViewModel()
    }
    
    func registerEmailAndPassword() {
        if let email = email, let password = password {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error?.localizedDescription {
                    print(error)
                } else {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
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
