//
//  Encodable+Generics.swift
//  UkrainianNews
//
//  Created by Markiyan Prysiazhniuk on 5/22/19.
//  Copyright © 2019 Markiyan Prysiazhniuk. All rights reserved.
//
import Foundation

extension Encodable {
    
    func encoded() throws -> Data {
        return try JSONEncoder().encode(self)
    }
}
