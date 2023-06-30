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
    @IBOutlet private weak var imageView: UIView!
    @IBOutlet private weak var labelsStackView: UIStackView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var actorDetailLabel: UILabel!
    @IBOutlet private weak var genderLabel: UILabel!
    @IBOutlet private weak var birthDayLabel: UILabel!
    @IBOutlet private weak var birthPlaceLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setViewModel() {
        viewModel = ActorDetailViewModel()
    }
}
