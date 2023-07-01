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

    init(owner: String?, movieID: Int?, comment: String?) {
        self.owner = owner
        self.movieID = movieID
        self.comment = comment
    }
}
