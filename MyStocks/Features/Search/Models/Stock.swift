//
//  Stock.swift
//  MyStocks
//
//  Created by David on 4/15/22.
//

import Foundation

struct Stock: Codable, Equatable  {
    static func == (lhs: Stock, rhs: Stock) -> Bool {
        lhs.symbol  ==  rhs.symbol &&
        lhs.companyInfo.region == rhs.companyInfo.region
        // etc...
    }
    
    var symbol: String
    var latestPrice:  Quote
    var companyInfo: Match      // Search Match Info  -  has company NAME
    
    init(ticker: String,  quote: Quote, match:  Match) {
        self.symbol  = ticker
        self.latestPrice = quote
        self.companyInfo = match
    }
    
    static let AAPL = Stock(ticker: "AAPL", quote: Quote.EmptyQuote, match: Match.FakeAAPL)
    static let GOOG = Stock(ticker: "GOOG", quote: Quote.EmptyQuote, match: Match.FakeGOOG)
}
