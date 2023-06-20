//
//  SpokenLanguage.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 20.06.2023.
//

import Foundation

struct SpokenLanguage: Codable {

    var englishName: String?
    var iso6391: String?
    var name: String?

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso6391 = "iso_639_1"
        case name = "name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        englishName = try values.decodeIfPresent(String.self, forKey: .englishName)
        iso6391 = try values.decodeIfPresent(String.self, forKey: .iso6391)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }
}
