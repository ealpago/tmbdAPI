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

    open func startLoading(){
        DispatchQueue.main.async {
            (self.view.window?.windowScene?.delegate as? BaseSceneDelegate)?.startLoading()
        }
    }

    open func stopLoading(){
        DispatchQueue.main.async {
            (self.view.window?.windowScene?.delegate as? BaseSceneDelegate)?.stopLoading()
        }
    }

    func setTitle(title:String = "", backVisible:Bool = true, font: UIFont = UIFont(name: "HelveticaNeue-Bold", size: 14.0)!, navigationBackgrounColor: UIColor = .darkerBrown ) {
        navigationItem.title = title
        navigationItem.hidesBackButton = true

        if(backVisible){
            createCustomBackBarButton()
        }

        navigationController?.hideHairline()
        changeNavigationBar(navigationBackgroundColor: navigationBackgrounColor, font: font)
    }

    private func createCustomBackBarButton(){
            let customBackButton = UIBarButtonItem(image: UIImage(systemName: "arrow.backward") , style: .plain, target: self, action: #selector(backAction(sender:)))
            customBackButton.imageInsets = UIEdgeInsets(top: 2, left: -4, bottom: 0, right: 0)
            customBackButton.tintColor = .white
            navigationItem.leftBarButtonItem = customBackButton
        }

        @objc func backAction(sender: UIBarButtonItem) {
            backAction()
        }

        func backAction(){
            if let navigationController = navigationController {
                navigationController.popViewController(animated: true)
            }else if let parentNavigationController = parentNavigationController(){
                parentNavigationController.popViewController(animated: true)
            }
        }

    open func changeNavigationBar(navigationBackgroundColor: UIColor, font: UIFont, textColor: UIColor = .white) {
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = navigationBackgroundColor
            appearance.titleTextAttributes = [NSAttributedString.Key.font: font, .foregroundColor: textColor]
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        } else {
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: UIBarMetrics.defaultPrompt)
            navigationController?.navigationBar.shadowImage = UIImage()
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: font, .foregroundColor: textColor]
            navigationController?.navigationBar.barTintColor = navigationBackgroundColor
            navigationController?.navigationBar.isTranslucent = false
        }
    }
}

extension UINavigationController {

    func hideHairline() {
        if let hairline = findHairlineImageViewUnder(navigationBar) {
            hairline.isHidden = true
        }
    }

    func restoreHairline() {
        if let hairline = findHairlineImageViewUnder(navigationBar) {
            hairline.isHidden = false
        }
    }

    func findHairlineImageViewUnder(_ view: UIView) -> UIImageView? {
        if view is UIImageView && view.bounds.size.height <= 1.0 {
            return view as? UIImageView
        }

        for subview in view.subviews {
            if let imageView = findHairlineImageViewUnder(subview) {
                return imageView
            }
        }
        return nil
    }
}
