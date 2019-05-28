//
//  NetworkAPI.swift
//  UkrainianNews
//
//  Created by Markiyan Prysiazhniuk on 5/22/19.
//  Copyright © 2019 Markiyan Prysiazhniuk. All rights reserved.
//
import Foundation

// -------------------------------------
// MARK: - NetworkApiError
// -------------------------------------
enum NetworkApiError: Error {
    case containerDataNotFound
}

// -------------------------------------
// MARK: - NetworkApi
// -------------------------------------
final class NetworkApi {
    unowned let networkManager: NetworkManagerProtocol = NetworkManager.shared
}

// -------------------------------------
// MARK: - Requests
// -------------------------------------
extension NetworkApi {
    
    func getNews(for country: String = "ua", completion: @escaping Response<[Article]>) {
        let request = NewsRouter.getNews(country: country)
        networkManager.makeContaineredRequest(request, completion: completion)
    }
}
