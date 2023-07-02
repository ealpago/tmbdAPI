//
//  WatchLaterViewModel.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 1.07.2023.
//

import UIKit
import Firebase

class WatchLaterViewModel: BaseViewModel {
    var watchLaterList: [DBMovies] = []
    var selectedCell:(Int)->() = {id in}
    let db = Firestore.firestore()

    func takeWatchListFromDB(completion: @escaping()->()) {
        db.collection(Constants.FirebaseConstant.watchLaterMovies).whereField(Constants.FirebaseDBMoviesConstants.favoriteListOwner, isEqualTo: UserDefaults.user ?? "").addSnapshotListener { querySnapshot, error in
            if let e = error {
                print("Get Documents Has Error \(e)")
            } else {
                if let snapshotDoc = querySnapshot?.documents {
                    for doc in snapshotDoc {
                        print(doc.data())
                        print(doc.documentID)
                        let data = doc.data()

                        if let owner = data[Constants.FirebaseDBMoviesConstants.favoriteListOwner] as? String, let movieID = data[Constants.FirebaseDBMoviesConstants.movieID] as? Int, let movieName = data[Constants.FirebaseDBMoviesConstants.movieName] as? String, let movieDescription = data[Constants.FirebaseDBMoviesConstants.movieDescription] as? String, let imagePath = data[Constants.FirebaseDBMoviesConstants.movieImage] as? String {
                               let newMovie = DBMovies(owner: owner, id: movieID, name: movieName, image: imagePath, description: movieDescription)
                            self.watchLaterList.append(newMovie)
                            completion()
                        }
                    }
                }
            }
        }
    }
}

extension WatchLaterViewModel: UITableViewDelegate, UITableViewDataSource {
    func setupTableView(with tableView: UITableView) {
        tableView.register(DetailedTableViewCell.nib, forCellReuseIdentifier: DetailedTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return watchLaterList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: DetailedTableViewCell.identifier, for: indexPath) as? DetailedTableViewCell {
            let cellModel = watchLaterList[indexPath.row]
            cell.setupCell(cellModel: CellModelItems(id: cellModel.id, name: cellModel.name, image: cellModel.image, description: cellModel.description))
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellID = watchLaterList[indexPath.row].id
        selectedCell(cellID ?? 0)
    }
}
