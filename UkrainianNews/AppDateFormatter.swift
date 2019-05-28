//
//  AppDateFormatter.swift
//  UkrainianNews
//
//  Created by Markiyan Prysiazhniuk on 5/22/19.
//  Copyright © 2019 Markiyan Prysiazhniuk. All rights reserved.
//
import Foundation

// -------------------------------------
// MARK: - AppDateFormatter
// -------------------------------------
enum AppDateFormatter {
    
    /// Private
    private static let apiFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")!
        return dateFormatter
    }()
    
    private static let displayFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "H:mm • d MMM"
        return dateFormatter
    }()
    
    
    /// Format
    enum Format {
        case api
        case display
    }
    
    /// Public
    static func date(from string: String?, format: Format) -> Date? {
        guard let string = string else { return nil }
        
        switch format {
        case .api:
            return apiFormatter.date(from: string)
        case .display:
            return displayFormatter.date(from: string)
        }
    }
    
    static func stringDate(from date: Date?, format: Format) -> String {
        guard let date = date else { return "" }
        
        switch format {
        case .api:
            return apiFormatter.string(from: date)
        case .display:
            return displayFormatter.string(from: date)
        }
    }
    
}
