//
//  DBComments.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 1.07.2023.
//

import Foundation

struct DBComments {
    var owner: String?
    var movieID: Int?
    var comment: String?
    var title: String?
    var vote: Int?

    init(owner: String?, movieID: Int?, comment: String?, title: String?, vote: Int?) {
        self.owner = owner
        self.movieID = movieID
        self.comment = comment
        self.title = title
        self.vote = vote
    }
}
