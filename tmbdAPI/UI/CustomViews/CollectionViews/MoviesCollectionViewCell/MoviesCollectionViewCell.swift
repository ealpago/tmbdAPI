//
//  MoviesCollectionViewCell.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 17.06.2023.
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var imageContainerView: UIView!
    @IBOutlet private weak var imageView: UIImageView!


    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageContainerView.layer.cornerRadius =  8
    }
}
