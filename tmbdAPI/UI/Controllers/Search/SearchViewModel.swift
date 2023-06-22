//
//  SearchViewModel.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 13.06.2023.
//

import UIKit

class SearchViewModel: BaseViewModel {

    var selectedCell:(Int)->() = {id in}
    var textDidChange:()->() = {}
    var reloadTableView:()->() = {}
    var deneme: [PopularMoviesResults] = []
    var searchedList: [SearchedMoviesResults] = []

    var collectionViewCellModelArray:[CellModel] = []
    var collectionCellModelItemsArray:[CellModelItems] = []

    func popularMovies(completion: @escaping()->()) {
        self.delegate?.startLoading()
        NetworkManager.service.request(requestRoute: .popularMovies, responseModel: PopularMovies.self) { [weak self] details in

            guard let result = details.results else {return}
            guard let self = self else {return}

            let sortedArray = result.sorted{$0.voteAverage ?? 0 < $1.voteAverage ?? 0}
            self.collectionCellModelItemsArray = sortedArray.compactMap { movies in
                CellModelItems(id: movies.id, name: movies.title, image: movies.posterPath, description: movies.overview, vote: movies.voteAverage, makingYear: movies.releaseDate, makingCountry: "deneme", duration: "213", budget: "2M", revenue: "3M", producer: "DENEME", writer: "DENEME2")
            }

            self.deneme = sortedArray
            self.collectionViewCellModelArray.append(CellModel(items: self.collectionCellModelItemsArray))
            completion()
        }
    }

    func searchMovies(query: String) {
        self.delegate?.startLoading()
        NetworkManager.service.request(requestRoute: .searchMovie(query: query), responseModel: SearchedMovies.self) { [weak self] details in
            guard let result = details.results else {return}
            guard let self = self else {return}

            searchedList = result
            DispatchQueue.main.async {
                self.reloadTableView()
            }
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
        return deneme.count
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
        let cellModel = collectionCellModelItemsArray[indexPath.row]
        selectedCell(cellModel.id ?? 0)
    }
}

extension SearchViewModel: UISearchBarDelegate {

    func setupSearchBar(with searchBar: UISearchBar) {
        searchBar.delegate = self
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText.trimmingCharacters(in: .whitespacesAndNewlines).count > 2 else {
            return
        }
        searchMovies(query: searchText)
    }
}
