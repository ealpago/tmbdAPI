//
//  CollectionTableViewCell.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 17.06.2023.
//

import UIKit

class CollectionTableViewCell: UITableViewCell {

    @IBOutlet private weak var collectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView(with: collectionView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension CollectionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {

    func setupCollectionView(with collectionView: UICollectionView) {
        collectionView.register(MoviesCollectionViewCell.nib, forCellWithReuseIdentifier: MoviesCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesCollectionViewCell.identifier,for: indexPath) as? MoviesCollectionViewCell {
                return cell
            }
            return UICollectionViewCell()
    }
}
