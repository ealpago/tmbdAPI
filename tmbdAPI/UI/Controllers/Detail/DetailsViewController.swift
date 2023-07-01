//
//  DetailViewController.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 13.06.2023.
//

import UIKit
import Firebase

class DetailsViewController: BaseViewController<DetailViewModel> {

    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var mainStackView: UIStackView!
    @IBOutlet private weak var previewStackView: UIStackView!
    @IBOutlet private weak var imageContainerView: UIView!
    @IBOutlet private weak var percentContainerView: UIView!
    @IBOutlet private weak var percentLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var headTitlesStackView: UIStackView!
    @IBOutlet private weak var titleContainerView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var detailsStackView: UIStackView!
    @IBOutlet private weak var topDetailStackView: UIStackView!
    @IBOutlet private weak var yearLabelView: DetailInfoView!
    @IBOutlet private weak var countryLabelView: DetailInfoView!
    @IBOutlet private weak var timeLabelView: DetailInfoView!
    @IBOutlet private weak var favoriteButton: UIButton!
    @IBOutlet private weak var watchLaterButton: UIButton!
    @IBOutlet private weak var commentSectionButton: UIButton!
    @IBOutlet private weak var budgetCategoryLabelView: DetailInfoView!
    @IBOutlet private weak var castCollectionView: UICollectionView!
    @IBOutlet private weak var recomendedCollectionView: UICollectionView!

    var movieDetailID: Int?
    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle(title: "Detaylar")
        setupUI()
        viewModel.takeData(movieID: movieDetailID ?? 0)
        viewModel.setupCollectionView(with: castCollectionView)
        viewModel.setupCollectionView(with: recomendedCollectionView)
        viewModel.reloadCollectionViewData = {
            DispatchQueue.main.async {
                self.setDataToUI()
                self.castCollectionView.reloadData()
                self.recomendedCollectionView.reloadData()
            }
        }
        viewModel.recommendedMovieTapped = { id in
                DispatchQueue.main.async {
                    self.viewModel.takeData(movieID: id ?? 0)
                    self.setDataToUI()
                    self.castCollectionView.reloadData()
                    self.recomendedCollectionView.reloadData()
                }
        }
        viewModel.movieTapped = { id in
            if let vc = "ActorDetailStoryboard".viewController(identifier: ActorDetailViewController.identifier) as? ActorDetailViewController {
                vc.personID = id
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }

    override func setViewModel() {
        viewModel = DetailViewModel()
    }

    func setupUI() {
        previewStackView.layer.cornerRadius = 8
        previewStackView.layer.borderColor = UIColor.brown.cgColor
        previewStackView.layer.borderWidth = 2
        yearLabelView.title = "2013"
        budgetCategoryLabelView.textAlignment = .left
        percentContainerView.layer.cornerRadius = percentContainerView.frame.height / 2
        percentContainerView.backgroundColor = .brown.withAlphaComponent(0.7)
        favoriteButton.layer.cornerRadius = 15
        favoriteButton.layer.borderColor = UIColor.brown.cgColor
        favoriteButton.layer.borderWidth = 2

        watchLaterButton.layer.cornerRadius = 15
        watchLaterButton.layer.borderColor = UIColor.brown.cgColor
        watchLaterButton.layer.borderWidth = 2

        commentSectionButton.layer.cornerRadius = 15
        commentSectionButton.layer.borderColor = UIColor.brown.cgColor
        commentSectionButton.layer.borderWidth = 2
    }

    func setDataToUI() {
        self.startLoading()
        if let data = viewModel.movieDetail {
            setTitle(title: data.title ?? "Detaylar")
            titleLabel.text = data.title
            descriptionLabel.text = data.overview
            yearLabelView.title = data.releaseDate ?? ""
            if let country = data.productionCompanies?.first?.originCountry {
                countryLabelView.title = "\(country)"
            }
            if let runTime = data.runtime {
                timeLabelView.title = "\(runTime)min"
            }
            if let budget = data.budget {
                budgetCategoryLabelView.title = "Bütçe: \(budget)$"
            }
            if let vote = data.voteAverage {
                percentLabel.text = String(format: "%.1f", vote)
            }
            DispatchQueue.main.async {
                let characterImageUrlPath = data.posterPath ?? ""
                guard let characterImageURL = URL(string: "https://image.tmdb.org/t/p/w500/"+characterImageUrlPath) else {return}
                self.imageView?.downloaded(from: characterImageURL)
            }
        }
        self.stopLoading()
    }

    @IBAction func addFavoriteButtonTapped(_ sender: UIButton) {
        var ref: DocumentReference? = nil
        if let movieID = movieDetailID, let user = Auth.auth().currentUser?.email, let movieName = titleLabel.text, let movieDescription = descriptionLabel.text {
            ref = db.collection("favorites").addDocument(data: [
                "favoriteListOwner" : user,
                    "movieID": movieID,
                "movieName": movieName,
                "movieDescription": movieDescription
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                }
            }
        }
    }

    @IBAction func addWatchLaterButtonTapped(_ sender: UIButton) {
    }

    @IBAction func showCommentsButtonTapped(_ sender: UIButton) {
    }
}
