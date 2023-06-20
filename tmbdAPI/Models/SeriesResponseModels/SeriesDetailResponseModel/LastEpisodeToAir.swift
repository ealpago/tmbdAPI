//
//  LastEpisodeToAir.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 20.06.2023.
//
import Foundation

struct LastEpisodeToAir: Codable {

    var airDate: String?
    var episodeNumber: Int?
    var id: Int?
    var name: String?
    var overview: String?
    var productionCode: String?
    var runtime: Int?
    var seasonNumber: Int?
    var showId: Int?
    var stillPath: String?
    var voteAverage: Float?
    var voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case airDate = "air_date"
        case episodeNumber = "episode_number"
        case id = "id"
        case name = "name"
        case overview = "overview"
        case productionCode = "production_code"
        case runtime = "runtime"
        case seasonNumber = "season_number"
        case showId = "show_id"
        case stillPath = "still_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        airDate = try values.decodeIfPresent(String.self, forKey: .airDate)
        episodeNumber = try values.decodeIfPresent(Int.self, forKey: .episodeNumber)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        overview = try values.decodeIfPresent(String.self, forKey: .overview)
        productionCode = try values.decodeIfPresent(String.self, forKey: .productionCode)
        runtime = try values.decodeIfPresent(Int.self, forKey: .runtime)
        seasonNumber = try values.decodeIfPresent(Int.self, forKey: .seasonNumber)
        showId = try values.decodeIfPresent(Int.self, forKey: .showId)
        stillPath = try values.decodeIfPresent(String.self, forKey: .stillPath)
        voteAverage = try values.decodeIfPresent(Float.self, forKey: .voteAverage)
        voteCount = try values.decodeIfPresent(Int.self, forKey: .voteCount)
    }
}
