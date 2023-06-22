//
//  SearchViewController.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 13.06.2023.
//

import UIKit

class SearchViewController: BaseViewController<SearchViewModel> {

    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setupTableView(with: tableView)
        viewModel.reloadTableView = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        viewModel.popularMovies {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.stopLoading()
            }
        }
        viewModel.selectedCell = { id in
            if let vc = "DetailsStoryboard".viewController(identifier: DetailsViewController.identifier) as? DetailsViewController{
                vc.movieDetailID = id
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = .white
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        changeNavigationBar(navigationBackgroundColor: .darkerBrown, font: UIFont())
    }

    override func setViewModel() {
        viewModel = SearchViewModel()
    }
}
