//
//  NetworkRouterProtocol.swift
//  UkrainianNews
//
//  Created by Markiyan Prysiazhniuk on 5/22/19.
//  Copyright © 2019 Markiyan Prysiazhniuk. All rights reserved.
//

import Foundation
import Alamofire

// -------------------------------------
// MARK: - Typealias
// -------------------------------------
typealias HttpMethod = Alamofire.HTTPMethod
typealias HttpHeaders = Alamofire.HTTPHeaders

// -------------------------------------
// MARK: - NetworkRouterError
// -------------------------------------
enum NetworkRouterError: Error {
    case failedToCreateURL
}

// -------------------------------------
// MARK: - NetworkRouterProtocol
// -------------------------------------
protocol NetworkRouterProtocol: URLRequestConvertible {
    
    /// Base URL for router, each router should have own unique baseURL
    var baseURL: String {get}
    
    /// Method for request
    var method: HttpMethod {get}
    
    /// Path for request
    var path: String {get}
    
    /// Aditional headers for request
    var headers: HttpHeaders {get}
    
    /// Optional query items
    var queryItems: [String: String]? {get}
    
    /// Optional body for request
    var postBody: Encodable? {get}
    
}

// -------------------------------------
// MARK: - Extras for Headers
// -------------------------------------
extension NetworkRouterProtocol {
    
    var defaultHeaders: HttpHeaders {
        return [:]
    }
    
    var headers: HttpHeaders {
        return [:]
    }
    
    var allHeaders: HttpHeaders {
        return [:]
    }
    
    var queryItems: [String: String]? {
        return nil
    }
    
    var postBody: Encodable? {
        return nil
    }
}

// -------------------------------------
// MARK: - Convertiong to URLRequest
// -------------------------------------
extension NetworkRouterProtocol {
    
    func asURLRequest() throws -> URLRequest {
        
        guard var componentsURL = URLComponents(string: baseURL + path) else { throw NetworkRouterError.failedToCreateURL }
        
        if let queryItems = queryItems {
            let queryItems = queryItems.map { URLQueryItem(name: $0.key, value: $0.value) }
            componentsURL.queryItems = queryItems
        }
        let requestURL = try componentsURL.asURL()
        var request = try URLRequest(url: requestURL, method: method, headers: allHeaders)
        
        if let postBody = postBody {
            let postData = try postBody.encoded()
            request.httpBody = postData
        }
        return request
    }
    
}
