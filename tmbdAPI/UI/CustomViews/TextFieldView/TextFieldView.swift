//
//  TextFieldView.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 29.06.2023.
//

import UIKit

class TextFieldView: UIView {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!

    var textFieldDidEnd:(String?)->() = {text in}
    var registerSection: RegisterCases? {
        didSet {
            if let register = registerSection {
                textField.attributedPlaceholder = NSAttributedString(
                    string: register.placeholder,
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.8)]
                )
                errorLabel.text = register.error
            }
        }
    }

    var loginSection: LoginCases? {
        didSet {
            if let login = loginSection {
                textField.attributedPlaceholder = NSAttributedString(
                    string: login.placeholder,
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.8)]
                )
                errorLabel.text = login.error
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        Bundle.main.loadNibNamed("TextFieldView", owner: self, options: nil)
        errorLabel.isHidden = true
        textField.delegate = self
        textField.layer.cornerRadius = 20
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.white.cgColor
        textField.addTarget(self, action: #selector(didEndEditing(_:)), for: .editingDidEnd)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

    @objc func didEndEditing(_ textField: UITextField) {
        var error: Int? = 1
        if let login = loginSection {
            if login == .email {
                if let text = textField.text {
                    error = isValidEmail(text) ? 1 : 0
                }
            }

            if login == .password {
                if let text = textField.text {
                    error = isValidPassword(text) ? 1 : 0
                }
            }
        } else {
            if registerSection == .email {
                if let text = textField.text {
                    error = isValidEmail(text) ? 1 : 0
                }
            }
            if registerSection == .name || registerSection == .surname {
                if let text = textField.text {
                    if text.isEmpty {
                        errorLabel.text = "Boş giriş yapılamaz"
                        error = isValidLetter(text) ? 1 : 0
                    } else {
                        errorLabel.text = registerSection?.error
                        error = isValidLetter(text) ? 1 : 0
                    }
                }
            }
            if registerSection == .password {
                if let text = textField.text {
                    error = isValidPassword(text) ? 1 : 0
                }
            }
        }

        errorLabel.isHidden = error == 1 ? true : false
        textField.layer.borderColor = error == 1 ? UIColor.white.cgColor : UIColor.red.cgColor
        textFieldDidEnd(textField.text)
    }

    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }

    func isValidLetter(_ name: String) -> Bool {
        let nameRegex = "^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$"
        let namePredicate = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        return namePredicate.evaluate(with: name)
    }

    func isValidPassword(_ password: String) -> Bool {
        if password.count < 6 {
             return false
        } else {
            return true
        }
    }
}

extension TextFieldView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
}
