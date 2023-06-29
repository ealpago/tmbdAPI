//
//  LoggedUser.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 29.06.2023.
//

import Foundation

struct LoggedUser: Codable {
    var name: String
    var surname: String
    var email: String

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case surname = "surname"
        case email = "email"
    }
}

