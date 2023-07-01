//
//  CommentsViewController.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 1.07.2023.
//

import UIKit
import Firebase

class CommentsViewController: BaseViewController<CommentsViewModel> {

    @IBOutlet private weak var previewStackView: UIStackView!
    @IBOutlet private weak var imageContainerView: UIView!
    @IBOutlet private weak var percentContainerView: UIView!
    @IBOutlet private weak var percentLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var headTitlesStackView: UIStackView!
    @IBOutlet private weak var titleContainerView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionContainerView: UIView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var commentsTableView: UITableView!
    @IBOutlet private weak var bottomView: UIView!
    @IBOutlet private weak var commentTextField: UITextField!
    @IBOutlet private weak var commentButton: UIButton!

    var movieDetail: MovieDetail?
    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle(title: "Yorumlar")
        viewModel.movieID = movieDetail?.id
        viewModel.setupTableView(with: commentsTableView)
        viewModel.takeCommentsFromDB {
            DispatchQueue.main.async {
                self.commentsTableView.reloadData()
            }
        }
        setupUI()
    }

    override func setViewModel() {
        viewModel = CommentsViewModel()
    }

    func setupUI() {
        previewStackView.layer.cornerRadius = 8
        previewStackView.layer.borderColor = UIColor.brown.cgColor
        previewStackView.layer.borderWidth = 2
        percentContainerView.layer.cornerRadius = percentContainerView.frame.height / 2
        percentContainerView.backgroundColor = .brown.withAlphaComponent(0.7)
        if let data = movieDetail {
            titleLabel.text = data.title
            descriptionLabel.text = data.overview
            if let vote = data.voteAverage {
                percentLabel.text = String(format: "%.1f", vote)
            }
            DispatchQueue.main.async {
                let characterImageUrlPath = data.posterPath ?? ""
                guard let characterImageURL = URL(string: "https://image.tmdb.org/t/p/w500/"+characterImageUrlPath) else {return}
                self.imageView?.downloaded(from: characterImageURL)
            }
        }
    }

    @IBAction func commentSendButtonTapped(_ sender: UIButton) {
        var ref: DocumentReference? = nil
        if let movieID = movieDetail?.id, let user = Auth.auth().currentUser?.email, let comment = commentTextField.text, commentTextField.text?.isEmpty == false {
            ref = db.collection(Constants.FirebaseConstant.moviesComments).addDocument(data: [
                "commentOwner": user,
                "movieID": movieID,
                "comment": comment
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                }
            }
            DispatchQueue.main.async {
                self.commentsTableView.reloadData()
                self.commentTextField.text = ""
            }
        }
    }
}
