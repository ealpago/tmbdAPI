//
//  PersonMovies.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 30.06.2023.
//

import Foundation

struct PersonMovies: Codable {

    let cast: [PersonsMoviesCasts]?
    let crew: [PersonsMoviesCrew]?
    let id: Int?

    enum CodingKeys: String, CodingKey {
        case cast = "cast"
        case crew = "crew"
        case id = "id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cast = try values.decodeIfPresent([PersonsMoviesCasts].self, forKey: .cast)
        crew = try values.decodeIfPresent([PersonsMoviesCrew].self, forKey: .crew)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
    }
}
