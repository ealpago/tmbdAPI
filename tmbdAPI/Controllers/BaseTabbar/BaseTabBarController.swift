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
    static let upcomingStoryBoardName = "UpcomingStoryboard"
    static let upcomingStoryBoardID = "UpcomingViewController"
    static let favoritesStoryBoardName = "FavoritesStoryboard"
    static let favoritesStoryBoardID = "FavoritesViewController"
}

enum TabbarItemType {
    case home, upcoming, favorites

    var name: String {
        switch self {
        case .home:
            return "HomeStoryboard"
        case .upcoming:
            return "UpcomingStoryboard"
        case .favorites:
            return "FavoritesStoryboard"
        }
    }

    var identifier: String {
        switch self {
        case .home:
            return "HomeViewController"
        case .upcoming:
            return "UpcomingViewController"
        case .favorites:
            return "FavoritesViewController"
        }
    }

    var image: UIImage {
        switch self {
        case .home:
            return UIImage(systemName: "tv.circle")!
        case .upcoming:
            return UIImage(systemName: "clock.badge.checkmark")!
        case .favorites:
            return  UIImage(systemName: "star")!
        }
    }
    var selectedImage: UIImage {
        switch self {
        case .home:
            return UIImage(systemName: "tv.circle.fill")!
        case .upcoming:
            return UIImage(systemName: "clock.badge.checkmark.fill")!
        case .favorites:
            return  UIImage(systemName: "star.fill")!
        }
    }
}

final class BaseTabBarController: UITabBarController {
    var items: [TabbarItemType] {
        [.home, .upcoming, .favorites]
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
