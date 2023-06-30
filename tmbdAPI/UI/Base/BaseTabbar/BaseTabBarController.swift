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
    static let searchStoryBoardName = "SearchStoryboard"
    static let searchStoryBoardID = "SearchViewController"
    static let profileStoryBoardName = "ProfileStoryboard"
    static let profileStoryBoardID = "ProfileViewController"
}

enum TabbarItemType {
    case home, upcoming, search, profile

    var name: String {
        switch self {
        case .home:
            return TabBarConstant.homeStoryBoardName
        case .upcoming:
            return TabBarConstant.upcomingStoryBoardName
        case .search:
            return TabBarConstant.searchStoryBoardName
        case .profile:
            return TabBarConstant.profileStoryBoardName
        }
    }

    var identifier: String {
        switch self {
        case .home:
            return TabBarConstant.homeStoryBoardID
        case .upcoming:
            return TabBarConstant.upcomingStoryBoardID
        case .search:
            return TabBarConstant.searchStoryBoardID
        case .profile:
            return TabBarConstant.profileStoryBoardID
        }
    }

    var image: UIImage {
        switch self {
        case .home:
            return UIImage(systemName: "tv.circle")!
        case .upcoming:
            return UIImage(systemName: "clock.badge.checkmark")!
        case .search:
            return UIImage(systemName: "magnifyingglass.circle")!
        case .profile:
            return UIImage(systemName: "person")!
        }
    }

    var selectedImage: UIImage {
        switch self {
        case .home:
            return UIImage(systemName: "tv.circle.fill")!
        case .upcoming:
            return UIImage(systemName: "clock.badge.checkmark.fill")!
        case .search:
            return UIImage(systemName: "magnifyingglass.circle.fill")!
        case .profile:
            return UIImage(systemName: "person.fill")!
        }
    }

    var title: String {
        switch self {
        case .home:
            return "Ana Sayfa"
        case .upcoming:
            return "Çok Yakında"
        case .search:
            return "Arama"
        case .profile:
            return "Profil"
        }
    }
}

final class BaseTabBarController: UITabBarController {
    var items: [TabbarItemType] {
        [.home, .upcoming, .search, .profile]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        UITabBar.appearance().backgroundColor = .white
        UITabBar.appearance().tintColor = .brown
    }

    func setupTabBar() {
        let views = items.compactMap { item in
            let vc = UIStoryboard(name: item.name, bundle: nil).instantiateViewController(withIdentifier: item.identifier)
            let tabBarItem = UITabBarItem(title: item.title,
                                          image: item.image,
                                          selectedImage: item.selectedImage)
            vc.tabBarItem = tabBarItem
            return vc
        }
        setViewControllers(views, animated: true)
    }
}
