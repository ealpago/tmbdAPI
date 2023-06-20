//
//  SeriesDetail.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 20.06.2023.
//

import Foundation

struct SeriesDetail: Codable {

    var adult: Bool?
    var backdropPath: String?
    var createdBy: [CreatedBy]?
    var episodeRunTime: [Int]?
    var firstAirDate: String?
    var genres: [Genre]?
    var homepage: String?
    var id: Int?
    var inProduction: Bool?
    var languages: [String]?
    var lastAirDate: String?
    var lastEpisodeToAir: LastEpisodeToAir?
    var name: String?
    var networks: [Network]?
    var nextEpisodeToAir: String?
    var numberOfEpisodes: Int?
    var numberOfSeasons: Int?
    var originCountry: [String]?
    var originalLanguage: String?
    var originalName: String?
    var overview: String?
    var popularity: Float?
    var posterPath: String?
    var productionCompanies: [Network]?
    var productionCountries: [ProductionCountry]?
    var seasons: [Season]?
    var spokenLanguages: [SeriesSpokenLanguage]?
    var status: String?
    var tagline: String?
    var type: String?
    var voteAverage: Float?
    var voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult = "adult"
        case backdropPath = "backdrop_path"
        case createdBy = "created_by"
        case episodeRunTime = "episode_run_time"
        case firstAirDate = "first_air_date"
        case genres = "genres"
        case homepage = "homepage"
        case id = "id"
        case inProduction = "in_production"
        case languages = "languages"
        case lastAirDate = "last_air_date"
        case lastEpisodeToAir
        case name = "name"
        case networks = "networks"
        case nextEpisodeToAir = "next_episode_to_air"
        case numberOfEpisodes = "number_of_episodes"
        case numberOfSeasons = "number_of_seasons"
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview = "overview"
        case popularity = "popularity"
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case seasons = "seasons"
        case spokenLanguages = "spoken_languages"
        case status = "status"
        case tagline = "tagline"
        case type = "type"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        adult = try values.decodeIfPresent(Bool.self, forKey: .adult)
        backdropPath = try values.decodeIfPresent(String.self, forKey: .backdropPath)
        createdBy = try values.decodeIfPresent([CreatedBy].self, forKey: .createdBy)
        episodeRunTime = try values.decodeIfPresent([Int].self, forKey: .episodeRunTime)
        firstAirDate = try values.decodeIfPresent(String.self, forKey: .firstAirDate)
        genres = try values.decodeIfPresent([Genre].self, forKey: .genres)
        homepage = try values.decodeIfPresent(String.self, forKey: .homepage)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        inProduction = try values.decodeIfPresent(Bool.self, forKey: .inProduction)
        languages = try values.decodeIfPresent([String].self, forKey: .languages)
        lastAirDate = try values.decodeIfPresent(String.self, forKey: .lastAirDate)
        lastEpisodeToAir = try LastEpisodeToAir(from: decoder)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        networks = try values.decodeIfPresent([Network].self, forKey: .networks)
        nextEpisodeToAir = try values.decodeIfPresent(String.self, forKey: .nextEpisodeToAir)
        numberOfEpisodes = try values.decodeIfPresent(Int.self, forKey: .numberOfEpisodes)
        numberOfSeasons = try values.decodeIfPresent(Int.self, forKey: .numberOfSeasons)
        originCountry = try values.decodeIfPresent([String].self, forKey: .originCountry)
        originalLanguage = try values.decodeIfPresent(String.self, forKey: .originalLanguage)
        originalName = try values.decodeIfPresent(String.self, forKey: .originalName)
        overview = try values.decodeIfPresent(String.self, forKey: .overview)
        popularity = try values.decodeIfPresent(Float.self, forKey: .popularity)
        posterPath = try values.decodeIfPresent(String.self, forKey: .posterPath)
        productionCompanies = try values.decodeIfPresent([Network].self, forKey: .productionCompanies)
        productionCountries = try values.decodeIfPresent([ProductionCountry].self, forKey: .productionCountries)
        seasons = try values.decodeIfPresent([Season].self, forKey: .seasons)
        spokenLanguages = try values.decodeIfPresent([SeriesSpokenLanguage].self, forKey: .spokenLanguages)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        tagline = try values.decodeIfPresent(String.self, forKey: .tagline)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        voteAverage = try values.decodeIfPresent(Float.self, forKey: .voteAverage)
        voteCount = try values.decodeIfPresent(Int.self, forKey: .voteCount)
    }
}
