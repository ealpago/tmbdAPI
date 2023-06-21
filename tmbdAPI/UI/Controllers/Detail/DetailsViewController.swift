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
    @IBOutlet private weak var categoriesDetailStackView: UIStackView!
    @IBOutlet private weak var firstCategoryLabelView: DetailInfoView!
    @IBOutlet private weak var secondCategoryLabelView: DetailInfoView!
    @IBOutlet private weak var thirdCategoryLabelView: DetailInfoView!
    @IBOutlet private weak var budgetCategoryLabelView: DetailInfoView!
    @IBOutlet private weak var revenuesCategoryLabelView: DetailInfoView!
    @IBOutlet private weak var recomendedCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle(title: "DR. Strange")
        setupUI()
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
        revenuesCategoryLabelView.textAlignment = .left
    }
}
