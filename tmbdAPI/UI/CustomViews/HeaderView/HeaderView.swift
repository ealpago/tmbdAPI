//
//  HeaderView.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 17.06.2023.
//

import UIKit

class HeaderView: UIView {

    //MARK: Outlets
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var mainStackView: UIStackView!
    @IBOutlet private weak var buttonContainerView: UIView!
    @IBOutlet private weak var headerMovieButton: UIButton!

    //MARK: Properties
    var headerMovieButtonTapped:()->() = {}

    //MARK: Init Setup
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    //MARK: Functions
    private func commonInit() {
        Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        headerMovieButton.layer.borderWidth = 2
        headerMovieButton.layer.borderColor = UIColor.brown.cgColor
    }

    //MARK: Actions
    @IBAction func headerMovieButtonTapped(_ sender: UIButton) {
        headerMovieButtonTapped()
    }
}
