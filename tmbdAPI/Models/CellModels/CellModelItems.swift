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

    init(id: Int?, name: String?, image: String?, description: String?) {
        self.id = id
        self.name = name
        self.image = image
        self.description = description
    }
}
