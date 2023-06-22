//
//  UpcomingViewModel.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 13.06.2023.
//

import UIKit

class UpcomingViewModel: BaseViewModel {
    var selectedCell:(Int)->() = {id in}

    var upcommingArray: [UpcomingMoviesResults] = []
    var collectionViewCellModelArray:[CellModel] = []
    var collectionCellModelItemsArray:[CellModelItems] = []

    func upcomingMovies(completion: @escaping()->()) {
        self.delegate?.startLoading()
        NetworkManager.service.request(requestRoute: .upcomingMovies, responseModel: UpcomingMovies.self) { [weak self] details in

            guard let result = details.results else {return}
            guard let self = self else {return}


            upcommingArray = result

            self.collectionCellModelItemsArray = result.compactMap { movies in
                CellModelItems(id: movies.id, name: movies.title, image: movies.posterPath, description: movies.overview)
            }

            self.collectionViewCellModelArray.append(CellModel(items: self.collectionCellModelItemsArray))
            self.delegate?.stopLoading()
            completion()
        }
    }
}

extension UpcomingViewModel: UITableViewDelegate, UITableViewDataSource {

    func setupTableView(with tableView: UITableView) {
        tableView.register(DetailedTableViewCell.nib, forCellReuseIdentifier: DetailedTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return upcommingArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: DetailedTableViewCell.identifier, for: indexPath) as? DetailedTableViewCell {
            let cellModel = collectionCellModelItemsArray[indexPath.row]
            cell.setupCell(cellModel: cellModel)
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellID = collectionCellModelItemsArray[indexPath.row].id
        selectedCell(cellID ?? 0)
    }
}
