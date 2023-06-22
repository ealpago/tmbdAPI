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

    private var itemModel: CellModelItems?
    var didCellTap:(Int?)->() = {id in}

    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageContainerView.layer.cornerRadius =  8
        let gesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        self.addGestureRecognizer(gesture)
    }

    func setupCell(cellModel: CellModelItems) {
        itemModel = cellModel
        if let itemModel = itemModel {
            DispatchQueue.main.async {
                let characterImageUrlPath = itemModel.image ?? ""
                guard let characterImageURL = URL(string: "https://image.tmdb.org/t/p/w500/"+characterImageUrlPath) else {return}
                self.imageView?.downloaded(from: characterImageURL)
            }
        }
    }

    @objc func cellTapped() {
        didCellTap(itemModel?.id)
    }
}
