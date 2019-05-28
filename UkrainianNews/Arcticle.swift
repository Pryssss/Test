//
//  Arcticle.swift
//  UkrainianNews
//
//  Created by Markiyan Prysiazhniuk on 5/22/19.
//  Copyright © 2019 Markiyan Prysiazhniuk. All rights reserved.
//
import Foundation

// -------------------------------------
// MARK: - Source
// -------------------------------------
struct Source: Codable {
    
    let id: String?
    let name: String
}

// -------------------------------------
// MARK: - Article
// -------------------------------------
struct Article: Codable {
    
    let source: Source
    let author: String?
    let title: String?
    let description: String?
    let content: String?
    let articleURL: URL?
    let imageURL: URL?
    let publishedAt: Date?
    
    /// CodingKeys
    enum CodingKeys: String, CodingKey {
        case source
        case author
        case title
        case description
        case articleURL = "url"
        case imageURL = "urlToImage"
        case publishedAt
        case content
    }
    
    /// Init
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        source = try container.decode(Source.self, forKey: .source)
        author = try container.decodeIfPresent(String.self, forKey: .author)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        content = try container.decodeIfPresent(String.self, forKey: .content)
        
        let rawImageURL = try container.decodeIfPresent(String.self, forKey: .imageURL)
        imageURL = URL(optional: rawImageURL)
        
        let rawArticleURL = try container.decodeIfPresent(String.self, forKey: .articleURL)
        articleURL = URL(optional: rawArticleURL)
        
        let rawPublishedAt = try container.decodeIfPresent(String.self, forKey: .publishedAt)
        publishedAt = AppDateFormatter.date(from: rawPublishedAt, format: .api)
    }
}
