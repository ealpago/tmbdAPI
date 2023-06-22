//
//  ServiceError.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 22.06.2023.
//
import UIKit

public struct ServiceError:Codable {
    public let status:Bool
    public let message:String?
}


public struct CustomError: Error {
    // MARK: Properties
    public var message: String?
    public var serviceError:ServiceError?
    public var statusCode:Int?

    init(_ message: String? = nil, serviceError:ServiceError? = nil, statusCode:Int? = nil) {
        self.message = message
        self.serviceError = serviceError
        self.statusCode = statusCode
    }
}
