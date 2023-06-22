//
//  UpcomingViewController.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 13.06.2023.
//

import UIKit

class UpcomingViewController: BaseViewController<UpcomingViewModel> {

    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setupTableView(with: tableView)
        viewModel.upcomingMovies {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        viewModel.selectedCell = { id in
            if let vc = "DetailsStoryboard".viewController(identifier: DetailsViewController.identifier) as? DetailsViewController{
                vc.movieDetailID = id
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        changeNavigationBar(navigationBackgroundColor: .darkerBrown, font: UIFont())
    }

    override func setViewModel() {
        viewModel = UpcomingViewModel()
    }
}
