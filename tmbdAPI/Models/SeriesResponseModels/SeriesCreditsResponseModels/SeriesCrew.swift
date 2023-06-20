//
//  SeriesCrew.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 20.06.2023.
//

import Foundation

struct SeriesCrew: Codable {

    let adult: Bool?
    let creditId: String?
    let department: String?
    let gender: Int?
    let id: Int?
    let job: String?
    let knownForDepartment: String?
    let name: String?
    let originalName: String?
    let popularity: Float?
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case adult = "adult"
        case creditId = "credit_id"
        case department = "department"
        case gender = "gender"
        case id = "id"
        case job = "job"
        case knownForDepartment = "known_for_department"
        case name = "name"
        case originalName = "original_name"
        case popularity = "popularity"
        case profilePath = "profile_path"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        adult = try values.decodeIfPresent(Bool.self, forKey: .adult)
        creditId = try values.decodeIfPresent(String.self, forKey: .creditId)
        department = try values.decodeIfPresent(String.self, forKey: .department)
        gender = try values.decodeIfPresent(Int.self, forKey: .gender)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        job = try values.decodeIfPresent(String.self, forKey: .job)
        knownForDepartment = try values.decodeIfPresent(String.self, forKey: .knownForDepartment)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        originalName = try values.decodeIfPresent(String.self, forKey: .originalName)
        popularity = try values.decodeIfPresent(Float.self, forKey: .popularity)
        profilePath = try values.decodeIfPresent(String.self, forKey: .profilePath)
    }
}
