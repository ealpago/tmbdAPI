//
//  HomeViewController.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 13.06.2023.
//

import UIKit

class HomeViewController: BaseViewController<HomeViewModel> {

    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setupTableView(with: tableView, view: view)
        viewModel.goToDetail = { id in
            if let vc = "DetailsStoryboard".viewController(identifier: DetailsViewController.identifier) as? DetailsViewController {
                vc.movieDetailID = id
                print(id)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        changeNavigationBar(navigationBackgroundColor: .darkerBrown, font: UIFont())
    }

    override func setViewModel() {
        viewModel = HomeViewModel()
    }
}
