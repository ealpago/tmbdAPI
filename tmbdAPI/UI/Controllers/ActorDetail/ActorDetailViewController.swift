//
//  ActorDetailViewController.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 30.06.2023.
//

import UIKit

class ActorDetailViewController: BaseViewController<ActorDetailViewModel> {

    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var contenView: UIView!
    @IBOutlet private weak var mainStackView: UIStackView!
    @IBOutlet private weak var topStackView: UIStackView!
    @IBOutlet private weak var imageContainerView: UIView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var labelsStackView: UIStackView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var actorDetailLabel: UILabel!
    @IBOutlet private weak var genderLabel: UILabel!
    @IBOutlet private weak var birthDayLabel: UILabel!
    @IBOutlet private weak var birthPlaceLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!

    var personID: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.takeData(personID: personID ?? 0)
        viewModel.setupCollectionView(with: collectionView)
        viewModel.reloadCollectionViewData = {
            DispatchQueue.main.async {
                self.setDataToUI()
                self.collectionView.reloadData()
            }
        }
        viewModel.movieTapped = { id in
            DispatchQueue.main.async {
                self.viewModel.takeData(personID: id ?? 0)
                self.setDataToUI()
                self.collectionView.reloadData()
            }
        }
    }

    override func setViewModel() {
        viewModel = ActorDetailViewModel()
    }

    func setDataToUI() {
        if let data = viewModel.personDetail {
            nameLabel.text = data.name
            actorDetailLabel.text = data.biography
            birthDayLabel.text = data.birthday ?? ""
            if let country = data.placeOfBirth {
                birthPlaceLabel.text = "\(country)"
            }
            DispatchQueue.main.async {
                let characterImageUrlPath = data.profilePath ?? ""
                guard let characterImageURL = URL(string: "https://image.tmdb.org/t/p/w500/"+characterImageUrlPath) else {return}
                self.imageView?.downloaded(from: characterImageURL)
            }
        }
    }
}
