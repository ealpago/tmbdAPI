//
//  CellModel.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 21.06.2023.
//

import Foundation

struct CellModel {
    var items:[CellModelItems?] = []

    init(items: [CellModelItems?]) {
        self.items = items
    }
}

