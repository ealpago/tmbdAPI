//
//  Constants.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 1.07.2023.
//

import Foundation

struct Constants {

    struct FirebaseConstant {
        static let favoriteMoviesCollection = "favorites"
        static let watchLaterMovies = "watchLater"
        static let moviesComments = "comments"
    }

    struct FirebaseDBMoviesConstants {
        static let favoriteListOwner = "favoriteListOwner"
        static let movieDescription = "movieDescription"
        static let movieID = "movieID"
        static let movieImage = "movieImage"
        static let movieName = "movieName"
    }

    struct FirebaseDBCommentsConstants {
        static let userMail = "user"
        static let vote = "vote"
        static let comment = "comment"
    }
}
