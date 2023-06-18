//
//  DetailViewController.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 13.06.2023.
//

import UIKit

class DetailsViewController: UIViewController {

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
    @IBOutlet private weak var yearLabel: UILabel!
    @IBOutlet private weak var countryLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var categoriesDetailStackView: UIStackView!
    @IBOutlet private weak var firstCategoryLabel: UILabel!
    @IBOutlet private weak var secondCategoryLabel: UILabel!
    @IBOutlet private weak var thirdCategoryLabel: UILabel!
    @IBOutlet private weak var budgetCategoryLabel: UILabel!
    @IBOutlet private weak var revenuesCategoryLabel: UILabel!
    @IBOutlet private weak var recomendedCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
