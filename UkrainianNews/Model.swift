
import Foundation

struct Model: Codable {
    let articles: [News]
}

struct Source: Codable {
    var name: String?
    var id: String?
}

struct News: Codable {
    var title: String?
    var url: String?
    var description: String?
    var urlToImage: URL?
    var source: Source?
    var publishedAt: String?
    var author: String?
    var content: String?
}

