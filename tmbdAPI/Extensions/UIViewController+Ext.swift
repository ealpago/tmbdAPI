//
//  UIView+Ext.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 17.06.2023.
//

import UIKit

extension UIViewController {

    func parentViewController() -> UIViewController?{
        parent?.view.superview?.parentViewController
    }

    func parentNavigationController() -> UINavigationController?{
        parent?.view.superview?.parentViewController?.navigationController
    }

    func parentView() -> UIView?{
        parentViewController()?.view
    }

    public static var bundle: Bundle {
        get {
            Bundle(for: self)
        }
    }

    public static var identifier: String {
        String(describing: self)
    }

    public static var nib: UINib {
        get {
            UINib(nibName: identifier, bundle: bundle)
        }
    }

    func registerKeyboardObserver(){
          NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)

          NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
      }

      func removeKeyboardObserver(){
          NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)

          NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
      }

      @objc func keyboardWillShow(notification:NSNotification) {
          guard let userInfo = notification.userInfo else { return }
          var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
          keyboardFrame = UIView(frame: UIScreen.main.bounds).convert(keyboardFrame, from: nil)
          (self as? KeyboardProtocol)?.keyboardWillShow(frame: keyboardFrame)
      }

      @objc func keyboardWillHide(notification:NSNotification) {
          (self as? KeyboardProtocol)?.keyboardWillHide()
      }
}

protocol KeyboardProtocol:NSObjectProtocol{
    func keyboardWillShow(frame:CGRect)
    func keyboardWillHide()
}
