//
//  BelongToCollection.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 22.06.2023.
//

import UIKit

struct BelongsToCollection: Codable {

    let backdropPath: String?
    let id: Int?
    let name: String?
    let posterPath: String?

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id = "id"
        case name = "name"
        case posterPath = "poster_path"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        backdropPath = try values.decodeIfPresent(String.self, forKey: .backdropPath)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        posterPath = try values.decodeIfPresent(String.self, forKey: .posterPath)
    }


}
