//
//  ActorDetailViewModel.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 30.06.2023.
//

import Foundation

class ActorDetailViewModel: BaseViewModel {
    var reloadCollectionViewData:()->() = {}
    var personDetail: PersonDetail?
    var recommendedMovies: [RecommendationResults] = []
    var recommendationMoviesModel:[CellModel] = []
    var recommendationMoviesModelItems:[CellModelItems] = []

    func takeData(personID: Int) {
        self.delegate?.startLoading()
        let group = DispatchGroup()
        group.enter()
        group.enter()

        getPersonDetail(personID: personID) {
            group.leave()
        }

        getPersonMovies(personID: personID) {
            group.leave()
        }

        group.notify(queue: .main, execute: {
            DispatchQueue.main.async {
                self.reloadCollectionViewData()
                self.delegate?.stopLoading()
            }
        })
    }

    func getPersonDetail(personID: Int, completion: @escaping()->()) {
        NetworkManager.service.request(requestRoute: .personDetail(personID: personID), responseModel: PersonDetail.self) { details in
            self.personDetail = details
            completion()
        }
    }

    func getPersonMovies(personID: Int, completion: @escaping()->()) {
       
    }
}

