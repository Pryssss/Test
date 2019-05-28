//
//  NetworkManagerProtocol.swift
//  UkrainianNews
//
//  Created by Markiyan Prysiazhniuk on 5/22/19.
//  Copyright © 2019 Markiyan Prysiazhniuk. All rights reserved.
//
import Foundation

// -------------------------------------
// MARK: - Result
// -------------------------------------
enum Result<T> {
    case success(T)
    case failure(Error)
}

// -------------------------------------
// MARK: - Response
// -------------------------------------
typealias Response<T> = (Result<T>) -> Void

// -------------------------------------
// MARK: - NetworkRouterProtocol
// -------------------------------------
protocol NetworkManagerProtocol: class {
    
    /// Makes request and tries parce responce object, can return network or parcing data error
    func makeRequest<T: Codable>(_ request: NetworkRouterProtocol, completion: @escaping Response<T>)
    func makeContaineredRequest<T: Codable>(_ request: NetworkRouterProtocol, completion: @escaping Response<T>)
}

