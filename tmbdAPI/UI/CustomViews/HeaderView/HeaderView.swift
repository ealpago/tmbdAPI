//
//  HeaderView.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 17.06.2023.
//

import UIKit

class HeaderView: UIView {

    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var mainStackView: UIStackView!
    @IBOutlet private weak var buttonsStackView: UIStackView!
    @IBOutlet private weak var moviesButton: UIButton!
    @IBOutlet private weak var seriesButton: UIButton!
    @IBOutlet private weak var imageView: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        moviesButton.layer.borderWidth = 1
        moviesButton.layer.borderColor = UIColor.brown.cgColor
        moviesButton.layer.cornerRadius = moviesButton.frame.height / 2
        seriesButton.layer.borderWidth = 1
        seriesButton.layer.borderColor = UIColor.brown.cgColor
        seriesButton.layer.cornerRadius = moviesButton.frame.height / 2
    }
}
