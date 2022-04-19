// News.swift

import Foundation


struct NewsResponse: Codable {
    let status: String
    let totalResults: Int
    var articles: [Article]
}

// verified  types  April 18 2022 for NewsAPI.org
struct Article: Identifiable, Codable {
    var id: UUID { return UUID() }
    let source: Source
    let author: String?
    var title: String
    let description: String?     //  including  this as String and the News does NOT load -- use optional  and it works better
    var url: String // URL
    var urlToImage: String?
    var imageUrl: String {
        return urlToImage?.replacingOccurrences(of: "http://", with: "https://") ?? "https://i.pinimg.com/originals/7b/28/98/7b2898990ae6ce6d6b277113d51b14e8.png"
    }
    let publishedAt: String  // can NOT use Date type  ::  YYYY-mm-ddTHH:MM:SSZ format in quotes
    let content: String?
    
    struct Source: Codable {
        let id: String?         // key path \.self.source.id   // inspecction of data - value  is null
        let name: String
    }
}
