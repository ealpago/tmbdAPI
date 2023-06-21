//
//  DetailedTableViewCell.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 14.06.2023.
//

import UIKit

class DetailedTableViewCell: UITableViewCell {

    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var leftImageView: UIView!
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var titlesStackView: UIStackView!
    @IBOutlet weak var detailTitleLabel: UILabel!
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var detailButton: UIButton!
    private var itemModel: CellModelItems?

    override func awakeFromNib() {
        super.awakeFromNib()
        mainStackView.layer.borderWidth = 2
        mainStackView.layer.borderColor = UIColor.brown.cgColor
        mainStackView.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setupCell(cellModel: CellModelItems) {
        itemModel = cellModel
        if let itemModel = itemModel {
            detailTitleLabel?.text = itemModel.name
            detailDescriptionLabel.text = itemModel.description
            DispatchQueue.main.async {
                let characterImageUrlPath = itemModel.image ?? ""
                guard let characterImageURL = URL(string: "https://image.tmdb.org/t/p/w500/"+characterImageUrlPath) else {return}
                self.detailImageView?.downloaded(from: characterImageURL)
            }
        }
    }
}
