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
        viewModel.selectedCell = {
            if let vc = "DetailsStoryboard".viewController(identifier: DetailsViewController.identifier) as? DetailsViewController{
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }

    override func setViewModel() {
        viewModel = UpcomingViewModel()
    }
}
