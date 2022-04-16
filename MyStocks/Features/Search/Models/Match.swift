// Search.swift

import Foundation

struct Match: Codable, Identifiable {
    var id: UUID { return UUID() }
    let symbol: String
    let name: String
    let type: String
    let region: String
    let marketOpen: String
    let marketClose: String
    let timezone: String
    let currency: String
    let matchScore: String
    
    private enum CodingKeys: String, CodingKey {
        case symbol         = "1. symbol"
        case name           = "2. name"         // company  name
        case type           = "3. type"
        case region         = "4. region"
        case marketOpen     = "5. marketOpen"
        case marketClose    = "6. marketClose"
        case timezone       = "7. timezone"
        case currency       = "8. currency"
        case matchScore     = "9. matchScore"
    }
    
    static var FakeAAPL = Match(symbol: "AAPL", name: "Apple Inc.", type: "Equity", region: "United States", marketOpen: "09:30", marketClose: "16:00", timezone: "UTC-04", currency: "USD", matchScore: "0.7435")
    static var FakeGOOG = Match(symbol: "GOOG", name: "Alphabet Inc.", type: "Equity", region: "United States", marketOpen: "09:30", marketClose: "16:00", timezone: "UTC-04", currency: "USD", matchScore: "0.7435")
    
    static var EmptyMatch = Match(symbol: "____", name: "Unknown", type: "Equity", region: "United States", marketOpen: "09:30", marketClose: "16:00", timezone: "UTC-04", currency: "USD", matchScore: "0.0012")
}
