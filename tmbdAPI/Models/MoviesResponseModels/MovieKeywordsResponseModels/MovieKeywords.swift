//
//  MovieKeywords.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 20.06.2023.
//

import Foundation

struct MovieKeywords: Codable {

    let id: Int?
    let keywords: [Keyword]?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case keywords = "keywords"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        keywords = try values.decodeIfPresent([Keyword].self, forKey: .keywords)
    }
}
