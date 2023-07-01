//
//  CommentsTableViewCell.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 1.07.2023.
//

import UIKit

class CommentsTableViewCell: UITableViewCell {

    @IBOutlet private weak var mainStackView: UIStackView!
    @IBOutlet private weak var userLabel: UILabel!
    @IBOutlet private weak var commentLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        mainStackView.layer.cornerRadius = 8
        mainStackView.layer.borderWidth = 2
        mainStackView.layer.borderColor = UIColor.brown.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setupCell(user: String?, comment: String?) {
        if let user = user, let comment = comment {
            userLabel.text = user
            commentLabel.text = comment
        }
    }
}
