//
//  HomeViewModel.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 13.06.2023.
//

import UIKit


final class HomeViewModel:BaseViewModel {

}

extension HomeViewModel: UITableViewDelegate, UITableViewDataSource {
    func setupTableView(with tableView: UITableView, view: UIView) {
        tableView.register(CollectionTableViewCell.nib, forCellReuseIdentifier: CollectionTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = HeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 500))
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Deneme"
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as? CollectionTableViewCell {
            return cell
        }
        return UITableViewCell()
    }
}
