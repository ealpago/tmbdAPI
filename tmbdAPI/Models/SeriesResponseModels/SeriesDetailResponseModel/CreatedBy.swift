//
//  CreatedBy.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 20.06.2023.
//
import Foundation

struct CreatedBy: Codable {

    let creditId: String?
    let gender: Int?
    let id: Int?
    let name: String?
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case creditId = "credit_id"
        case gender = "gender"
        case id = "id"
        case name = "name"
        case profilePath = "profile_path"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        creditId = try values.decodeIfPresent(String.self, forKey: .creditId)
        gender = try values.decodeIfPresent(Int.self, forKey: .gender)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        profilePath = try values.decodeIfPresent(String.self, forKey: .profilePath)
    }
}
