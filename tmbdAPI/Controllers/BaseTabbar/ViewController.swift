//
//  BaseTabBarController.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 11.06.2023.
//

import UIKit

enum TabBarConstant {
    static let homeStoryBoardName = "HomeStoryboard"
    static let homeStoryBoardID = "HomeViewController"
    static let addStoryBoardName = "AddStoryboard"
    static let addStoryBoardID = "AddViewController"
    static let detailsStoryBoardName = "DetailsStoryboard"
    static let detailsStoryBoardID = "DetailsViewController"
}

enum TabbarItemType {
    case home, add, pie

    var name: String {
        switch self {
        case .home:
            return "HomeStoryboard"
        case .add:
            return "AddStoryboard"
        case .pie:
            return "DetailsStoryboard"
        }
    }

    var identifier: String {
        switch self {
        case .home:
            return "HomeViewController"
        case .add:
            return "AddViewController"
        case .pie:
            return "DetailsViewController"
        }
    }

    var image: UIImage {
        switch self {
        case .home:
            return UIImage(named: "timeSVG")!
        case .add:
            return UIImage(named: "addSVG")!
        case .pie:
            return  UIImage(named: "pieSVG")!
        }
    }
    var selectedImage: UIImage {
        switch self {
        case .home:
            return UIImage(named: "selectedTimeSVG")!
        case .add:
            return UIImage(named: "selectedAddSVG")!
        case .pie:
            return UIImage(named: "selectedPieSVG")!
        }
    }
}

final class BaseTabBarController: UITabBarController {
    var items: [TabbarItemType] {
        [.home, .add, .pie]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        UITabBar.appearance().backgroundColor = .white
        UITabBar.appearance().tintColor = .black
    }

    func setupTabBar() {
        let views = items.compactMap { item in
            let vc = UIStoryboard(name: item.name, bundle: nil).instantiateViewController(withIdentifier: item.identifier)

            let tabBarItem = UITabBarItem(title: nil,
                                          image: item.image,
                                          selectedImage: item.selectedImage)
            vc.tabBarItem = tabBarItem


            return vc
        }
        setViewControllers(views, animated: true)
    }
}
