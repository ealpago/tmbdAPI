//
//  NowPlayingMovies.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 20.06.2023.
//

import Foundation

struct NowPlayingMovies: Codable {

    let dates : Date?
    let page : Int?
    let results : [NowPlayingMoviesResults]?
    let totalPages : Int?
    let totalResults : Int?

    enum CodingKeys: String, CodingKey {
        case dates
        case page = "page"
        case results = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        dates = try Date(from: decoder)
        page = try values.decodeIfPresent(Int.self, forKey: .page)
        results = try values.decodeIfPresent([NowPlayingMoviesResults].self, forKey: .results)
        totalPages = try values.decodeIfPresent(Int.self, forKey: .totalPages)
        totalResults = try values.decodeIfPresent(Int.self, forKey: .totalResults)
    }
}
