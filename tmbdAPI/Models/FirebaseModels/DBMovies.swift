//
//  DBMovies.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 1.07.2023.
//
import Foundation

struct DBMovies {
    var owner: String?
    var id: Int?
    var name: String?
    var image: String?
    var description: String?

    init(owner: String?, id: Int?, name: String?, image: String?, description: String?) {
        self.owner = owner
        self.id = id
        self.name = name
        self.image = image
        self.description = description
    }
}
