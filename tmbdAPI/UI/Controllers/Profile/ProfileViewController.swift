//
//  ProfileViewController.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 30.06.2023.
//

import UIKit
import Firebase

class ProfileViewController: BaseViewController<ProfileViewModel> {

    @IBOutlet private weak var userStackView: UIStackView!
    @IBOutlet private weak var welcomeLabel: UILabel!
    @IBOutlet private weak var userMailLabel: UILabel!
    @IBOutlet private weak var listsStackView: UIStackView!
    @IBOutlet private weak var watchLaterButton: UIButton!
    @IBOutlet private weak var favoritesButton: UIButton!
    @IBOutlet private weak var logoutButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setViewModel() {
        viewModel = ProfileViewModel()
    }

    @IBAction func watchLaterButtonTapped(_ sender: UIButton) {
        if let vc = "WatchLaterStoryboard".viewController(identifier: WatchLaterViewController.identifier) as? WatchLaterViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    @IBAction func favoritesButtonTapped(_ sender: UIButton) {
        if let vc = "FavoritesStoryboard".viewController(identifier: FavoritesViewController.identifier) as? FavoritesViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            let vc = "Main".viewController(identifier: "LoginViewController")
            vc.navigationItem.hidesBackButton = true
            navigationController?.pushViewController(vc, animated: true)
            UserDefaults.clearAll()
            UserDefaults.standard.synchronize()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
}
