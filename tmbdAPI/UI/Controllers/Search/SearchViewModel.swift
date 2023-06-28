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
    var popularMoviesArray: [PopularMoviesResults] = []
    var searchedList: [SearchedMoviesResults] = []

    var collectionCellModelItemsArray:[CellModelItems] = []

    func popularMovies(completion: @escaping()->()) {
        self.delegate?.startLoading()
        NetworkManager.service.request(requestRoute: .popularMovies, responseModel: PopularMovies.self) { [weak self] details in

            guard let result = details.results else {return}
            guard let self = self else {return}

            let sortedArray = result.sorted{$0.voteAverage ?? 0 < $1.voteAverage ?? 0}
            self.collectionCellModelItemsArray = sortedArray.compactMap { movies in
                CellModelItems(id: movies.id, name: movies.title, image: movies.posterPath, description: movies.overview)
            }

            self.popularMoviesArray = sortedArray
            completion()
            self.delegate?.stopLoading()
        }
    }

    func searchMovies(query: String) {
        self.delegate?.startLoading()
        NetworkManager.service.request(requestRoute: .searchMovie(query: query), responseModel: SearchedMovies.self) { details in
            guard let result = details.results else {return}

            self.searchedList = result
            self.collectionCellModelItemsArray = self.searchedList.compactMap { movies in
                CellModelItems(id: movies.id, name: movies.title, image: movies.posterPath, description: movies.overview)
            }

            DispatchQueue.main.async { [self] in
                reloadTableView()
                delegate?.stopLoading()
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
            return popularMovies() {
                self.reloadTableView()
            }

        }
        searchMovies(query: searchText)
    }
}
