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
    }

    override func setViewModel() {
        viewModel = HomeViewModel()
    }
}
