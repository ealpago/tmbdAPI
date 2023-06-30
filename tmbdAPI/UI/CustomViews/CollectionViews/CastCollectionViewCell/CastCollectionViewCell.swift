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

    private var itemModel: Cast?
    var didCellTap:(Int?)->() = {id in}

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 2
        let gesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        self.addGestureRecognizer(gesture)
    }

    func setupUI(collectionCast: Cast) {
        itemModel = collectionCast
        castLabel.text = collectionCast.name
        DispatchQueue.main.async {
            let characterImageUrlPath = collectionCast.profilePath ?? ""
            guard let characterImageURL = URL(string: "https://image.tmdb.org/t/p/w500/"+characterImageUrlPath) else {return}
            self.imageView?.downloaded(from: characterImageURL)
        }
    }

    @objc func cellTapped() {
        didCellTap(itemModel?.id)
    }
}
