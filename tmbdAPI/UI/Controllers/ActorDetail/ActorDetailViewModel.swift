//
//  ActorDetailViewModel.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 30.06.2023.
//

import UIKit

class ActorDetailViewModel: BaseViewModel {
    var reloadCollectionViewData:()->() = {}
    var movieTapped:(Int?)->() = {id in}
    var personDetail: PersonDetail?
    var personMovies: [PersonsMoviesCasts] = []
    var moviesModel:[CellModel] = []
    var moviesModelItems:[CellModelItems] = []

    func takeData(personID: Int) {
        self.delegate?.startLoading()
        let group = DispatchGroup()
        group.enter()
//        group.enter()

        getPersonDetail(personID: personID) {
            group.leave()
        }

//        getPersonMovies(personID: personID) {
//            group.leave()
//        }

        group.notify(queue: .main, execute: {
            DispatchQueue.main.async {
                self.reloadCollectionViewData()
                self.delegate?.stopLoading()
            }
        })
    }

    func getPersonDetail(personID: Int, completion: @escaping()->()) {
        NetworkManager.service.request(requestRoute: .personDetail(personID: personID), responseModel: PersonDetail.self) { details in
            self.personDetail = details
            completion()
        }
    }

    func getPersonMovies(personID: Int, completion: @escaping()->()) {
        NetworkManager.service.request(requestRoute: .personMovies(personID: personID), responseModel: PersonMovies.self) { details in
            guard let results = details.cast else {return}
            self.personMovies = results

            self.moviesModelItems = results.compactMap { movies in
                CellModelItems(id: movies.id, name: movies.title, image: movies.posterPath, description: movies.overview)
            }

            self.moviesModel.append(CellModel(items: self.moviesModelItems))

            completion()
        }
    }
}

extension ActorDetailViewModel: UICollectionViewDelegate, UICollectionViewDataSource {
    func setupCollectionView(with collectionView: UICollectionView) {
        collectionView.register(MoviesCollectionViewCell.nib, forCellWithReuseIdentifier: MoviesCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return personMovies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesCollectionViewCell.identifier, for: indexPath) as? MoviesCollectionViewCell else {
            return UICollectionViewCell()
        }
        let cellModel = moviesModelItems[indexPath.row]
        cell.setupCell(cellModel: cellModel)
        cell.didCellTap = movieTapped
        return cell
    }
}
