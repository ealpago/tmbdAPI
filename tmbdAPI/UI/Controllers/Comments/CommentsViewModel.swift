//
//  CommentsViewModel.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 1.07.2023.
//

import UIKit
import Firebase

class CommentsViewModel: BaseViewModel {
    var comments: [DBComments] = []
    let db = Firestore.firestore()

    func takeCommentsFromDB(completion: @escaping()->()) {
        db.collection(Constants.FirebaseConstant.moviesComments).addSnapshotListener { querySnapshot, error in
            self.comments = []
            if let e = error {
                print("Get Documents Has Error \(e)")
            } else {
                if let snapshotDoc = querySnapshot?.documents {
                    for doc in snapshotDoc {
                        print(doc.data())
                        let data = doc.data()

                        if let owner = data[Constants.FirebaseDBCommentsConstants.userMail] as? String, let movieID = data[Constants.FirebaseDBCommentsConstants.movieID] as? Int, let comment = data[Constants.FirebaseDBCommentsConstants.comment] as? String {
                            let newComment = DBComments(owner: owner, movieID: movieID, comment: comment)
                            self.comments.append(newComment)
                            completion()
                        }
                    }
                }
            }
        }
    }}

extension CommentsViewModel: UITableViewDelegate, UITableViewDataSource {
    func setupTableView(with tableView: UITableView) {
        tableView.register(CommentsTableViewCell.nib, forCellReuseIdentifier: CommentsTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CommentsTableViewCell.identifier, for: indexPath) as? CommentsTableViewCell {
            let cellModel = comments[indexPath.row]
            cell.setupCell(user: cellModel.owner, comment: cellModel.comment)
            return cell
        }
        return UITableViewCell()
    }
}
