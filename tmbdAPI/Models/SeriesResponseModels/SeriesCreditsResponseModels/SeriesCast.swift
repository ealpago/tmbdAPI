//
//  SeriesCast.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 20.06.2023.
//

import Foundation

struct SeriesCast: Codable {

    var adult: Bool?
    var character: String?
    var creditId: String?
    var gender: Int?
    var id: Int?
    var knownForDepartment: String?
    var name: String?
    var order: Int?
    var originalName: String?
    var popularity: Float?
    var profilePath: String?

    enum CodingKeys: String, CodingKey {
        case adult = "adult"
        case character = "character"
        case creditId = "credit_id"
        case gender = "gender"
        case id = "id"
        case knownForDepartment = "known_for_department"
        case name = "name"
        case order = "order"
        case originalName = "original_name"
        case popularity = "popularity"
        case profilePath = "profile_path"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        adult = try values.decodeIfPresent(Bool.self, forKey: .adult)
        character = try values.decodeIfPresent(String.self, forKey: .character)
        creditId = try values.decodeIfPresent(String.self, forKey: .creditId)
        gender = try values.decodeIfPresent(Int.self, forKey: .gender)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        knownForDepartment = try values.decodeIfPresent(String.self, forKey: .knownForDepartment)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        order = try values.decodeIfPresent(Int.self, forKey: .order)
        originalName = try values.decodeIfPresent(String.self, forKey: .originalName)
        popularity = try values.decodeIfPresent(Float.self, forKey: .popularity)
        profilePath = try values.decodeIfPresent(String.self, forKey: .profilePath)
    }
}
