// API.swift

import Foundation

struct API {
    
    static var baseUrl: String {
        return "https://www.alphavantage.co/query?"
    }
    
    static func symbolSearchUrl(for searchKey: String) -> String {
        return urlBy(symbol: .search, searchKey: searchKey)
    }
    
    static func quoteUrl(for searchKey: String) -> String {
        return urlBy(symbol: .quote, searchKey: searchKey)
    }
    
    private static func urlBy(symbol: SymbolFunction, searchKey: String) -> String {
        switch symbol {
        case .search:
            return "\(baseUrl)function=\(symbol.rawValue)&apikey=\(key)&keywords=\(searchKey)"
        case .quote:
            return "\(baseUrl)function=\(symbol.rawValue)&apikey=\(key)&symbol=\(searchKey)"
        }
    }
    
    enum SymbolFunction: String {
        case search = "SYMBOL_SEARCH"
        case quote = "GLOBAL_QUOTE"
    }
}

//API key:   2VYP6T8EKZ86PDB7  for davidakoontz@gmail.com
//API  key:  DK7TE9W6L2MSO3VV  for  cards.inspireme@gmail.com
//API key:  PXSKJ57OA0E4RNUS   for  inspireme.cards2day@gmail.com


extension API {
    static var key: String {
        //return "BAD_APIKEY"         //  "BAD_APIKEY" worked just  fine for symbolSearch
        let keys  = ["41UY1WI73RS730QQ", "PXSKJ57OA0E4RNUS", "DK7TE9W6L2MSO3VV", "2VYP6T8EKZ86PDB7"]
        return keys.randomElement()!      // AlphaVantage key for david@koontz.name
    }
}
