// StockQuoteManager.swift

import Foundation

final class StockQuoteManager: QuoteManagerProtocol, ObservableObject {
    @Published var quotes: [Quote] = []
    @Published var stocks: [Stock] = []
    
    func download(stocks: [String], completion: @escaping (Result<[Quote], NetworkError>) -> Void) {
        var internalQuotes = [Quote]()
        let downloadQueue = DispatchQueue(label: "com.LifeWorksIQ.MyStocks.downloadQueue")
        let downloadGroup = DispatchGroup()
        
        stocks.forEach { (stock) in
            downloadGroup.enter()
            let url = URL(string: API.quoteUrl(for: stock))!
            NetworkManager<GlobalQuoteResponse>().fetch(from: url) { (result) in
                switch result {
                case .failure(let err):
                    print(err)
                    downloadQueue.async {
                        downloadGroup.leave()
                    }
                    
                case .success(let resp):
                    downloadQueue.async {
                        internalQuotes.append(resp.quote)
                        downloadGroup.leave()
                    }
                }
            }
        }
        
        downloadGroup.notify(queue: DispatchQueue.global()) {
            completion(.success(internalQuotes))
            DispatchQueue.main.async {
                self.quotes.append(contentsOf: internalQuotes)
            }
        }
    }
    
    
    func requestAQuote(ticker: String, completion: @escaping (Result<[Quote], NetworkError>) -> Void) {
        var internalQuotes = [Quote]()
        let downloadQueue = DispatchQueue(label: "com.LifeWorksIQ.MyStocks.downloadQueue")
        let downloadGroup = DispatchGroup()
        
        //ticker.forEach { (stock) in
            downloadGroup.enter()
            let url = URL(string: API.quoteUrl(for: ticker))!
            NetworkManager<GlobalQuoteResponse>().fetch(from: url) { (result) in
                switch result {
                case .failure(let err):
                    print(err)
                    downloadQueue.async {
                        downloadGroup.leave()
                    }
                    
                case .success(let resp):
                    downloadQueue.async {
                        internalQuotes.append(resp.quote)
                        downloadGroup.leave()
                    }
                }
            }
       // }
        
        downloadGroup.notify(queue: DispatchQueue.global()) {
            completion(.success(internalQuotes))
            DispatchQueue.main.async {
                self.quotes.append(contentsOf: internalQuotes)
            }
        }
    }
    
    
    
    func requestAQuoteforStock(ticker: String, completion: @escaping (Result<[Stock], NetworkError>) -> Void) {
        var internalStocks = [Stock]()
        //var internalQuotes = [Quote]()
        let downloadQueue = DispatchQueue(label: "com.LifeWorksIQ.MyStocks.downloadQueue")
        let downloadGroup = DispatchGroup()
        
        //ticker.forEach { (stock) in
            downloadGroup.enter()
            let url = URL(string: API.quoteUrl(for: ticker))!
            NetworkManager<GlobalQuoteResponse>().fetch(from: url) { (result) in
                switch result {
                case .failure(let err):
                    print(err)
                    downloadQueue.async {
                        downloadGroup.leave()
                    }
                    
                case .success(let resp):
                    downloadQueue.async {
                        internalStocks.append(Stock(ticker: ticker, quote: resp.quote, match: Match.EmptyMatch))
                        downloadGroup.leave()
                    }
                }
            }
       // }
        
        downloadGroup.notify(queue: DispatchQueue.global()) {
            completion(.success(internalStocks))
            DispatchQueue.main.async {
                self.stocks.append(contentsOf: internalStocks)
            }
        }
    }
}
