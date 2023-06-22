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
    @IBOutlet private weak var headerMovieImage: UIImageView!

    //MARK: Properties
    var headerMovieButtonTapped:(Int)->() = {id in}
    var movieDetail: [NowPlayingMoviesResults] = []

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
        headerMovieImage.layer.borderWidth = 2
        headerMovieImage.layer.borderColor = UIColor.brown.cgColor
        let gesture = UITapGestureRecognizer(target: self, action: #selector(gestureTapped))
        headerMovieImage.addGestureRecognizer(gesture)
        headerMovieImage.isUserInteractionEnabled = true
        nowPlayingMovies {
            DispatchQueue.main.async {
                let firstMovie = self.movieDetail.first
                let characterImageUrlPath = firstMovie?.posterPath ?? ""
                guard let characterImageURL = URL(string: "https://image.tmdb.org/t/p/w500/"+characterImageUrlPath) else {return}
                self.headerMovieImage.downloaded(from: characterImageURL)
            }
        }
    }

    func nowPlayingMovies(completion: @escaping()->()) {
        NetworkManager.service.request(requestRoute: .nowPlayingMovies, responseModel: NowPlayingMovies.self) { [weak self] details in

            guard let result = details.results else {return}
            guard let self = self else {return}

            movieDetail = result
            completion()
        }
    }

    @objc func gestureTapped() {
        headerMovieButtonTapped(movieDetail.first?.id ?? 0)
    }
}
