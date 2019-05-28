//
//  NewsRouter.swift
//  UkrainianNews
//
//  Created by Markiyan Prysiazhniuk on 5/22/19.
//  Copyright © 2019 Markiyan Prysiazhniuk. All rights reserved.
//
import Foundation

// -------------------------------------
// MARK: - NewsRouter
// -------------------------------------
enum NewsRouter: NetworkRouterProtocol {
    
    /// Constants
    private enum Constants {
        static let baseURL = "https://newsapi.org/"
        static let apiKey = "0cff1368c1d1445d9a0bccb6063a5220"
    }
    
    /**
     Returns user profile, access_token, refresh_token if rigth credentionls were provided
     - body: Must contain existing user email and password
     */
    case getNews(country: String)
}

// -------------------------------------
// MARK: - Base info
// -------------------------------------
extension NewsRouter {
    var baseURL: String {
        return Constants.baseURL
    }
    
    var method: HttpMethod {
        switch self {
        case .getNews:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getNews:
            return "v2/top-headlines"
        }
    }
    
    var queryItems: [String: String]? {
        switch self {
        case .getNews(let country):
            return ["country": country, "apiKey": Constants.apiKey]
        }
    }
}
