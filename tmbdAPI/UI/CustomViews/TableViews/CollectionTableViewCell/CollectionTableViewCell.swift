//
//  CollectionTableViewCell.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 17.06.2023.
//

import UIKit

class CollectionTableViewCell: UITableViewCell {

    @IBOutlet private weak var collectionView: UICollectionView!

    var collectionViewCellModelArray:[CellModel] = []
    var collectionCellModelItemsArray:[CellModelItems] = []

    public typealias CompletionHandlerWithBoolStatus = (_ status: Bool) -> Void


    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView(with: collectionView)
        callingMovies()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func callingMovies() {
        let group = DispatchGroup()
        group.enter()
        group.enter()
        group.enter()
        group.enter()

        nowPlayingMovies {
            group.leave()
        }

        upcomingMovies {
            group.leave()
        }

        popularMovies {
            group.leave()
        }


        topRatedMovies {
            group.leave()
        }

        group.notify(queue: .main, execute: {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        })
    }

    func nowPlayingMovies(completion: @escaping()->()) {
        NetworkManager.service.request(requestRoute: .nowPlayingMovies, responseModel: NowPlayingMovies.self) { [weak self] details in

            guard let result = details.results else {return}
            guard let self = self else {return}

            self.collectionCellModelItemsArray = result.compactMap { movies in
                CellModelItems(id: movies.id, name: movies.title, image: movies.posterPath, description: movies.overview, vote: movies.voteAverage, makingYear: movies.releaseDate, makingCountry: "deneme", duration: "213", budget: "2M", revenue: "3M", producer: "DENEME", writer: "DENEME2")
            }

            self.collectionViewCellModelArray.append(CellModel(items: self.collectionCellModelItemsArray))
            completion()
        }
    }

    func popularMovies(completion: @escaping()->()) {
        NetworkManager.service.request(requestRoute: .popularMovies, responseModel: PopularMovies.self) { [weak self] details in

            guard let result = details.results else {return}
            guard let self = self else {return}

            self.collectionCellModelItemsArray = result.compactMap { movies in
                CellModelItems(id: movies.id, name: movies.title, image: movies.posterPath, description: movies.overview, vote: movies.voteAverage, makingYear: movies.releaseDate, makingCountry: "deneme", duration: "213", budget: "2M", revenue: "3M", producer: "DENEME", writer: "DENEME2")
            }

            self.collectionViewCellModelArray.append(CellModel(items: self.collectionCellModelItemsArray))
            completion()
        }
    }

    func upcomingMovies(completion: @escaping()->()) {
        NetworkManager.service.request(requestRoute: .upcomingMovies, responseModel: UpcomingMovies.self) { [weak self] details in

            guard let result = details.results else {return}
            guard let self = self else {return}

            self.collectionCellModelItemsArray = result.compactMap { movies in
                CellModelItems(id: movies.id, name: movies.title, image: movies.posterPath, description: movies.overview, vote: movies.voteAverage, makingYear: movies.releaseDate, makingCountry: "deneme", duration: "213", budget: "2M", revenue: "3M", producer: "DENEME", writer: "DENEME2")
            }

            self.collectionViewCellModelArray.append(CellModel(items: self.collectionCellModelItemsArray))
            completion()
        }
    }

    func topRatedMovies(completion: @escaping()->()) {
        NetworkManager.service.request(requestRoute: .topRatedMovies, responseModel: TopRatedMovies.self) { [weak self] details in

            guard let result = details.results else {return}
            guard let self = self else {return}

            self.collectionCellModelItemsArray = result.compactMap { movies in
                CellModelItems(id: movies.id, name: movies.title, image: movies.posterPath, description: movies.overview, vote: movies.voteAverage, makingYear: movies.releaseDate, makingCountry: "deneme", duration: "213", budget: "2M", revenue: "3M", producer: "DENEME", writer: "DENEME2")
            }

            self.collectionViewCellModelArray.append(CellModel(items: self.collectionCellModelItemsArray))
            completion()
        }
    }

}

extension CollectionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {

    func setupCollectionView(with collectionView: UICollectionView) {
        collectionView.register(MoviesCollectionViewCell.nib, forCellWithReuseIdentifier: MoviesCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionCellModelItemsArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesCollectionViewCell.identifier,for: indexPath) as? MoviesCollectionViewCell {

            return cell
        }
        return UICollectionViewCell()
    }
}
