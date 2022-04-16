// UserDefaultsManager.swift

import Foundation

final class UserDefaultsManager {
//    private static let symbolKey = "SYMBOL_KEY"
    private let stocksDefaultKey = "STOCKS_LIST"
    let Defaults = UserDefaults.standard
    
//    var savedSymbols = [String]()
    var savedStocks = [Stock]()
    
    static let shared = UserDefaultsManager()
    
    private init() {
        get()
    }
    
    func get() {
        //if let saved =  UserDefaults.standard.array(forKey: stocksDefaultKey) as? [Stock] {
        if  let savedStocksData = Defaults.object(forKey: stocksDefaultKey) as?  Data {
            let decoder = JSONDecoder()
            if let loadedStocks = try? decoder.decode([Stock].self, from: savedStocksData) {
                savedStocks = loadedStocks
                print("\n\nList of Saved Stock Symbols:\n\(loadedStocks)")
            }
        }
    }
    
//    func get() {
//        if let saved = UserDefaults.standard.array(forKey: Self.symbolKey) as? [String] {
//            savedSymbols = saved
//            print("\n\nList of Saved Stock Symbols:\n\(saved)")
//        }
//    }
    
    func set(match: Match) {
        let encoder = JSONEncoder()
        let stock = Stock(ticker: match.symbol, quote: Quote.EmptyQuote, match: match)
        savedStocks.append(stock)
        if let encodedData = try? encoder.encode(savedStocks) {
            let Defaults = UserDefaults.standard
            Defaults.set(encodedData, forKey: stocksDefaultKey)
        }
        
        //UserDefaults.standard.set( savedStocks, forKey: stocksDefaultKey)
        print("\n\nSaved Stock:\n\(stock.symbol) \(stock.companyInfo.name)")
    }
    
//    func set(symbol: String) {
//        savedSymbols.append(symbol)
//        UserDefaults.standard.set(self.savedSymbols, forKey: Self.symbolKey)
//        print("\n\nList of Saved Stock Symbols:\n\(savedSymbols)")
//    }
}
