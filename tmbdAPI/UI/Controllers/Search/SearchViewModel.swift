//
//  SearchViewModel.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 13.06.2023.
//

import UIKit

class SearchViewModel: BaseViewModel {

    var selectedCell:()->() = {}

    var collectionViewCellModelArray:[CellModel] = []
    var collectionCellModelItemsArray:[CellModelItems] = []

    func popularMovies(completion: @escaping()->()) {
        NetworkManager.service.request(requestRoute: .popularMovies, responseModel: PopularMovies.self) { [weak self] details in

            guard let result = details.results else {return}
            guard let self = self else {return}

            let sortedArray = result.sorted{$0.voteAverage ?? 0 < $1.voteAverage ?? 0}
            self.collectionCellModelItemsArray = sortedArray.compactMap { movies in
                CellModelItems(id: movies.id, name: movies.title, image: movies.posterPath, description: movies.overview, vote: movies.voteAverage, makingYear: movies.releaseDate, makingCountry: "deneme", duration: "213", budget: "2M", revenue: "3M", producer: "DENEME", writer: "DENEME2")
            }

            self.collectionViewCellModelArray.append(CellModel(items: self.collectionCellModelItemsArray))
            print(self.collectionViewCellModelArray.count)
            print(self.collectionCellModelItemsArray.count)
            completion()
        }
    }


}

extension SearchViewModel: UITableViewDelegate, UITableViewDataSource {
    func setupTableView(with tableView: UITableView) {
        tableView.register(DetailedTableViewCell.nib, forCellReuseIdentifier: DetailedTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collectionCellModelItemsArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: DetailedTableViewCell.identifier, for: indexPath) as? DetailedTableViewCell {
            let cellModel = collectionCellModelItemsArray[indexPath.row]
            cell.setupCell(cellModel: cellModel)
            return cell
        }
        return UITableViewCell()
    }
}
