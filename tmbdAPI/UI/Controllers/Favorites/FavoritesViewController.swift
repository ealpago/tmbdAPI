//
//  FavoritesViewController.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 1.07.2023.
//

import UIKit

class FavoritesViewController: BaseViewController<FavoritesViewModel> {

    @IBOutlet private weak var favoritesTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle(title: "Favori Filmlerim")
        viewModel.setupTableView(with: favoritesTableView)
        viewModel.takeFavoritesFromDB {
            DispatchQueue.main.async {
                self.favoritesTableView.reloadData()
            }
        }
        viewModel.selectedCell = { id in
            if let vc = "DetailsStoryboard".viewController(identifier: DetailsViewController.identifier) as? DetailsViewController{
                vc.movieDetailID = id
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }

    override func setViewModel() {
        viewModel = FavoritesViewModel()
    }
}
