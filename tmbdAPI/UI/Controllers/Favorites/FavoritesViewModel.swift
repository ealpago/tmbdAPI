//
//  FavoritesViewModel.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 1.07.2023.
//

import UIKit

class FavoritesViewModel: BaseViewModel {
    var favoritesList: [String] = []

    func takeFavoritesFromDB() {
        
    }
    
}

extension FavoritesViewModel: UITableViewDelegate, UITableViewDataSource {
    func setupTableView(with tableView: UITableView) {
        tableView.register(DetailedTableViewCell.nib, forCellReuseIdentifier: DetailedTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: DetailedTableViewCell.identifier, for: indexPath) as? DetailedTableViewCell {
//            let cellModel = collectionCellModelItemsArray[indexPath.row]
//            cell.setupCell(cellModel: cellModel)
            return cell
        }
        return UITableViewCell()
    }
}
