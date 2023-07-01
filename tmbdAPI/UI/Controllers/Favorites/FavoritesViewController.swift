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
    }

    override func setViewModel() {
        viewModel = FavoritesViewModel()
    }
}
