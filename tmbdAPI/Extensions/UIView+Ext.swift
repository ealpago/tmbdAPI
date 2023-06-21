//
//  UIView+Ext.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 18.06.2023.
//

import UIKit

extension UIView {
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

    public var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
