//
//  DetailViewModel.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 13.06.2023.
//

import UIKit

class DetailViewModel: BaseViewModel {
    var recommendedMovieTapped:(Int?)->() = {id in}
    var movieTapped:(Int?)->() = {id in}
    var reloadCollectionViewData:()->() = {}
    var movieDetail: MovieDetail?
    var movieCast: MovieCredits?
    var recommendedMovies: [RecommendationResults] = []
    var recommendationMoviesModel:[CellModel] = []
    var recommendationMoviesModelItems:[CellModelItems] = []


    func takeData(movieID: Int) {
        self.delegate?.startLoading()
        let group = DispatchGroup()
        group.enter()
        group.enter()
        group.enter()

        getMovieDetail(movieID: movieID) {
            group.leave()
        }

        getMovieCast(movieID: movieID) {
            group.leave()
        }

        getMovieRecommendation(movieID: movieID) {
            group.leave()
        }

        group.notify(queue: .main, execute: {
            DispatchQueue.main.async {
                self.reloadCollectionViewData()
                self.delegate?.stopLoading()
            }
        })
    }

    func getMovieDetail(movieID: Int, completion: @escaping()->()) {
        NetworkManager.service.request(requestRoute: .moviesDetail(movieID: movieID), responseModel: MovieDetail.self) { details in
            self.movieDetail = details
            completion()
        }
    }

    func getMovieCast(movieID: Int, completion: @escaping()->()) {
        NetworkManager.service.request(requestRoute: .moviesCredits(movieID: movieID), responseModel: MovieCredits.self) { details in
            self.movieCast = details
            completion()
        }
    }

    func getMovieRecommendation(movieID: Int, completion: @escaping()->()) {
        NetworkManager.service.request(requestRoute: .movieRecommendations(movieID: movieID), responseModel: MovieRecommendations.self) { details in
            guard let results = details.results else {return}
            self.recommendedMovies = results

            self.recommendationMoviesModelItems = results.compactMap { movies in
                CellModelItems(id: movies.id, name: movies.title, image: movies.posterPath, description: movies.overview)
            }

            self.recommendationMoviesModel.append(CellModel(items: self.recommendationMoviesModelItems))

            completion()
        }
    }
}

extension DetailViewModel: UICollectionViewDelegate, UICollectionViewDataSource {
    func setupCollectionView(with collectionView: UICollectionView) {
        collectionView.register(CastCollectionViewCell.nib, forCellWithReuseIdentifier: CastCollectionViewCell.identifier)
        collectionView.register(MoviesCollectionViewCell.nib, forCellWithReuseIdentifier: MoviesCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            return movieCast?.cast?.count ?? 0
            } else {
            return recommendedMovies.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCollectionViewCell.identifier, for: indexPath) as? CastCollectionViewCell else {
                return UICollectionViewCell()
            }
            if let cast = movieCast?.cast?[indexPath.row] {
                cell.setupUI(collectionCast: cast)
            }
            cell.didCellTap = movieTapped
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesCollectionViewCell.identifier, for: indexPath) as? MoviesCollectionViewCell else {
                return UICollectionViewCell()
            }
            let cellModel = recommendationMoviesModelItems[indexPath.row]
            cell.setupCell(cellModel: cellModel)
            cell.didCellTap = recommendedMovieTapped
            return cell
        }
    }
}
