//
//  NetworkServices.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 19.06.2023.
//

import Foundation

private let movieBaseURL = "https://api.themoviedb.org/3/movie/"
private let seriesBaseURL = "https://api.themoviedb.org/3/tv/"
private let apiKey = "?api_key=5f68b0ee2af0bcbf53e5984bc7e12b10"

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

public enum NetworkRouter {
    case nowPlayingMovies
    case popularMovies
    case topRatedMovies
    case upcomingMovies
    case moviesDetail(movieID: Int)
    case moviesCredits(movieID: Int)
    case movieKeywords(movieID: Int)
    case movieRecommendations(movieID: Int)
    case similarMovies(movieID: Int)
    case searchMovie(query: String)

    public var method: HTTPMethod {
        switch self {
        case .nowPlayingMovies:
            return .get
        case .popularMovies:
            return .get
        case .topRatedMovies:
            return .get
        case .upcomingMovies:
            return .get
        case .moviesDetail(_):
            return .get
        case .moviesCredits(_):
            return .get
        case .movieKeywords(_):
            return .get
        case .movieRecommendations(_):
            return .get
        case .similarMovies(_):
            return .get
        case .searchMovie(_):
            return .get
        }
    }

    public var path: String {
        switch self {
        case .nowPlayingMovies:
            return movieBaseURL + "now_playing" + apiKey
        case .popularMovies:
            return movieBaseURL + "popular" + apiKey
        case .topRatedMovies:
            return movieBaseURL + "top_rated" + apiKey
        case .upcomingMovies:
            return movieBaseURL + "upcoming" + apiKey
        case .moviesDetail(let movieID):
            return movieBaseURL + "\(movieID)" + apiKey
        case .moviesCredits(let movieID):
            return movieBaseURL + "\(movieID)" + "/credits" + apiKey
        case .movieKeywords(let movieID):
            return movieBaseURL + "\(movieID)" + "/keywords" + apiKey
        case .movieRecommendations(let movieID):
            return movieBaseURL + "\(movieID)" + "/recommendations" + apiKey
        case .similarMovies(let movieID):
            return movieBaseURL + "\(movieID)" + "/similar" + apiKey
        case .searchMovie(query: let query):
            return movieBaseURL + apiKey + "&query=\(query)"
        }
    }
}

class NetworkManager {
    static let service = NetworkManager()
    public func request<T: Codable>(requestRoute: NetworkRouter, responseModel:T.Type, completion:@escaping (_ details: T) -> Void){
        if let url = URL(string: requestRoute.path){
            var request = URLRequest(url: url)
            request.httpMethod = requestRoute.method.rawValue
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: request) { data, response, error in
                do {
                    let data = try JSONDecoder().decode(T.self, from: data!)
                    completion(data)
                } catch let e as NSError {
                    print("error : \(e)")
                }
            }
            task.resume()
        }
    }
}
