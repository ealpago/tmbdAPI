//
//  CastCollectionViewCell.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 22.06.2023.
//

import UIKit

class CastCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var mainStackView: UIStackView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var castLabel: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 2
    }

}
