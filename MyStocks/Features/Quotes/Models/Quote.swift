// Quote.swift

import Foundation

struct Quote: Codable {
    var symbol: String
    var open: String
    var high: String
    var low: String
    var price: String
    var change: String
    var changePercent: String
    
    private enum CodingKeys: String, CodingKey {
        case symbol = "01. symbol"
        case open = "02. open"
        case high = "03. high"
        case low = "04. low"
        case price = "05. price"
        case change = "09. change"
        case changePercent = "10. change percent"
    }
    
    static var EmptyQuote = Quote(symbol: "Unknown", open: "0.00", high: "0.00", low: "0.00", price: "0.00", change: "0.00", changePercent: "0.00")

}

extension Quote: Identifiable {
    var id: UUID {
        return UUID()
    }
}

