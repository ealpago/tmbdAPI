//
//  PopularMovies.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 20.06.2023.
//

import Foundation

struct PopularMovies: Codable {

    var page: Int?
    var results: [PopularMoviesResults]?
    var totalPages: Int?
    var totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page = "page"
        case results = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        page = try values.decodeIfPresent(Int.self, forKey: .page)
        results = try values.decodeIfPresent([PopularMoviesResults].self, forKey: .results)
        totalPages = try values.decodeIfPresent(Int.self, forKey: .totalPages)
        totalResults = try values.decodeIfPresent(Int.self, forKey: .totalResults)
    }
}
