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

    override func awakeFromNib() {
        super.awakeFromNib()
        mainStackView.layer.borderWidth = 2
        mainStackView.layer.borderColor = UIColor.brown.cgColor

        mainStackView.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
