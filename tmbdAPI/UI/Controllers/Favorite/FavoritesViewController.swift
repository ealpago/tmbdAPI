//
//  FavoritesViewController.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 13.06.2023.
//

import UIKit

class FavoritesViewController: BaseViewController<FavoritesViewModel> {

    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setupTableView(with: tableView)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        changeNavigationBar(navigationBackgroundColor: .darkerBrown, font: UIFont())
    }

    override func setViewModel() {
        viewModel = FavoritesViewModel()
    }
}
