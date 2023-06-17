//
//  UpcomingViewController.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 13.06.2023.
//

import UIKit

class UpcomingViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView(with: tableView)
    }
}

extension UpcomingViewController: UITableViewDelegate, UITableViewDataSource {

    private func setupTableView(with tableView: UITableView) {
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
}
