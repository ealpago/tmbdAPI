//
//  SeriesKeywords.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 20.06.2023.
//

import Foundation

struct SeriesKeywords: Codable {

    let id: Int?
    let results: [SeriesKeywordResults]?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case results = "results"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        results = try values.decodeIfPresent([SeriesKeywordResults].self, forKey: .results)
    }
}
