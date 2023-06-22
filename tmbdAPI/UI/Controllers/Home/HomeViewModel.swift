//
//  HomeViewModel.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 13.06.2023.
//

import UIKit


final class HomeViewModel:BaseViewModel {
    var goToDetail:(Int)->() = {id in}
}

extension HomeViewModel: UITableViewDelegate, UITableViewDataSource {
    func setupTableView(with tableView: UITableView, view: UIView) {
        tableView.register(CollectionTableViewCell.nib, forCellReuseIdentifier: CollectionTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        let headerView = HeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 500))
        headerView.headerMovieButtonTapped = {id in
            self.goToDetail(id)
        }
        tableView.tableHeaderView = headerView
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return HomeTableViewSection.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let label = UILabel(frame: CGRect(x: 20, y: 0, width: tableView.frame.width - 32, height: 20))
        view.addSubview(label)
        label.textColor = .white
        label.text = HomeTableViewSection.allCases[section].headerTitle
        return view
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as? CollectionTableViewCell {
            let section = indexPath.section
            cell.tableSection = section
            cell.collectionViewTapped = { movieID in
                self.goToDetail(movieID ?? 0)
            }
            return cell
        }
        return UITableViewCell()
    }
}

enum HomeTableViewSection: CaseIterable {
    case nowPlaying
    case upcoming
    case popular
    case topRated

    var headerTitle: String{
        switch self {
        case .nowPlaying:
            return "Vizyonda"
        case .upcoming:
            return "Gelecek"
        case .popular:
            return "Popüler"
        case .topRated:
            return "En iyiler"
        }
    }
}
