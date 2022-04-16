// SearchManager.swift

import Foundation

final class SearchManager: ObservableObject {
    @Published var matches = [Match]()
    
    func searchStocks(searchTerm: String) {
        // searchTerm cannot contain bad URL characters like a space e.g. "IBM, CRM"  NOR does multiple terms work yet.
        let escapedTerm  =  searchTerm.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
        
        NetworkManager<SearchResponse>().fetch(from: URL(string: API.symbolSearchUrl(for: escapedTerm))!) { (result) in
            switch result {
            case .failure(let err):
                print("\nNetworkManager: Search for symbol \(searchTerm) \nERROR: \(err)")
            case .success(let resp):
                DispatchQueue.main.async {
                    self.matches = resp.bestMatches
                }
            }
        }
    }
}
