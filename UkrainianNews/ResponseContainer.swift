//
//  ResponseContainer.swift
//  UkrainianNews
//
//  Created by Markiyan Prysiazhniuk on 5/22/19.
//  Copyright © 2019 Markiyan Prysiazhniuk. All rights reserved.
//

import Foundation

// -------------------------------------
// MARK: - ResponseContainer
// -------------------------------------
struct ResponseContainer<T: Codable>: Codable {
    
    let status: String
    let count: Int
    let result: T
    
    /// Keys
    struct DynamicKey: CodingKey {
        var stringValue: String
        
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        init?(intValue: Int) {
            stringValue = ""
        }
        var intValue: Int? { return nil }
    }
    
    enum CodingKeys: String, CodingKey {
        case status
        case count = "totalResults"
        case result
    }
    
    /// Init
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        count = try container.decode(Int.self, forKey: .count)
        status = try container.decode(String.self, forKey: .status)
        
        let dynamicContainer = try decoder.container(keyedBy: DynamicKey.self)
        var genericResult: T?
        
        dynamicContainer.allKeys.forEach { key in
            if let value = try? dynamicContainer.decodeIfPresent(T.self, forKey: key) {
                genericResult = value
            }
        }
        if let genericResult = genericResult {
            result = genericResult
        } else {
            throw NetworkApiError.containerDataNotFound
        }
    }
}

