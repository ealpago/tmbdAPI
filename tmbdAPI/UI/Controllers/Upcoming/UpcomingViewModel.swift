//
//  UpcomingViewModel.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 13.06.2023.
//

import UIKit

class UpcomingViewModel: BaseViewModel {
    var selectedCell:()->() = {}
}

extension UpcomingViewModel: UITableViewDelegate, UITableViewDataSource {

    func setupTableView(with tableView: UITableView) {
        tableView.register(DetailedTableViewCell.nib, forCellReuseIdentifier: DetailedTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: DetailedTableViewCell.identifier, for: indexPath) as? DetailedTableViewCell {
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCell()
    }
}
