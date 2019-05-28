//
//  URL+Optional.swift
//  UkrainianNews
//
//  Created by Markiyan Prysiazhniuk on 5/22/19.
//  Copyright © 2019 Markiyan Prysiazhniuk. All rights reserved.
//
import Foundation

// -------------------------------------
// MARK: - URL + Optional
// -------------------------------------
extension URL {
    
    init?(optional string: String?) {
        guard let string = string else {
            return nil
        }
        self.init(string: string)
    }
}
