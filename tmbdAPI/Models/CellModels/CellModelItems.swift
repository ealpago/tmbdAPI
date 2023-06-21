//
//  CellModelItems.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 21.06.2023.
//

import Foundation

struct CellModelItems {
    var id: Int?
    var name: String?
    var image: String?
    var description: String?
    var vote: Int?
    var makingYear: String?
    var makingCountry: String?
    var duration: String?
    var budget: String?
    var revenue: String?
    var producer: String?
    var writer: String?

    init(id: Int?, name: String?, image: String?, description: String?, vote: Int?, makingYear: String?, makingCountry: String?, duration: String?, budget: String?, revenue: String?, producer: String?, writer: String?) {
        self.id = id
        self.name = name
        self.image = image
        self.description = description
        self.vote = vote
        self.makingYear = makingYear
        self.makingCountry = makingCountry
        self.duration = duration
        self.budget = budget
        self.revenue = revenue
        self.producer = producer
        self.writer = writer
    }
}
