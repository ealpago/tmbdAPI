//
//  BaseViewModel.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 21.06.2023.
//

import Foundation

open class BaseViewModel: NSObject {
    public var delegate: BaseViewModelProtocol?
    
}

public protocol BaseViewModelProtocol {
    func startLoading()
    func stopLoading()
}
