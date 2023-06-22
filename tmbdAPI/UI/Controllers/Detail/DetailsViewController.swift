//
//  DetailViewController.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 13.06.2023.
//

import UIKit

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
    @IBOutlet private weak var budgetCategoryLabelView: DetailInfoView!
    @IBOutlet private weak var castCollectionView: UICollectionView!
    @IBOutlet private weak var recomendedCollectionView: UICollectionView!

    var movieDetailID: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle(title: "Detaylar")
        setupUI()
        viewModel.takeData(movieID: 238)
        viewModel.setupCollectionView(with: castCollectionView)
        viewModel.setupCollectionView(with: recomendedCollectionView)
        viewModel.reloadCollectionViewData = {
            DispatchQueue.main.async {
                self.setDataToUI()
                self.castCollectionView.reloadData()
                self.recomendedCollectionView.reloadData()
            }
        }
        viewModel.recommendedMovieTapped = {
            if let vc = "DetailsStoryboard".viewController(identifier: DetailsViewController.identifier) as? DetailsViewController {
                DispatchQueue.main.async {
                    self.setDataToUI()
                    self.castCollectionView.reloadData()
                    self.recomendedCollectionView.reloadData()
                }
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
    }

    func setDataToUI() {
        if let data = viewModel.movieDetail {
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
            DispatchQueue.main.async {
                let characterImageUrlPath = data.posterPath ?? ""
                guard let characterImageURL = URL(string: "https://image.tmdb.org/t/p/w500/"+characterImageUrlPath) else {return}
                self.imageView?.downloaded(from: characterImageURL)
            }
        }
    }
}
