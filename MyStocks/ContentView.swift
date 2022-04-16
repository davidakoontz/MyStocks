//
//  ContentView.swift
//  MyStocks
//
//  Created by David on 4/13/22.
//


import SwiftUI

struct ContentView: View {
    
    @ObservedObject var stockQuoteManager = StockQuoteManager()
    @ObservedObject var newsManager = NewsDownloadManager()
    
    @State private var stocks = UserDefaultsManager.shared.savedStocks     // was a [String] savedSymbols  ; now [Stock]
    @State private var searchTerm = ""
    @State private var newsOpen = false
    @State private var oldStocks = [Stock]()
    
    init() {
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack {
            Color.black
            
            VStack(alignment: .leading) {
                if newsOpen {
                    withAnimation {
                        MiniQuoteView(stockQuotes: stockQuoteManager)
                            .foregroundColor(.white)
                            .padding(.top, 50)
                            .frame(height: newsOpen ? 100 : 0)
                            .transition(.move(edge: .top))
                    }
                } else {
                    withAnimation {
                        HeaderView(stocks: $stocks)         // was a [String]
                            .padding(.top, 50)
                            .frame(height: newsOpen ? 0 : 100)
                            .transition(.move(edge: .top))
                    }
                }
                
                List {
                    Group {
                        SearchTextView(searchTerm: $searchTerm)
                        
                        ForEach(filteredStocks() ) { quote in
                            QuoteCell(quote: quote)
                        }
                    }.listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets())
                }.onAppear {
                    //fetchData(for: stocks)                  // was a [String]
                    fetchQuotes(for: stocks)
                    oldStocks = stocks
                }.onChange(of: stocks, perform: { value in
                   // fetchData(for: stocks.difference(from: oldStocks))      // was a [String]
                    //fetchQuotes(for: stocks.difference(from: oldStocks) )
                    fetchMultipleQuotes(for: stocks)
                    oldStocks = stocks
                })
                .listStyle(PlainListStyle())
                .foregroundColor(.white)
            }.padding(.horizontal, 32)
            .padding(.bottom, UIScreen.main.bounds.height * 0.21)
            
            NewsSheetView(newsOpen: $newsOpen, newsManager: newsManager)
            
        }.edgesIgnoringSafeArea(.all)
    }
    
    private func filteredStockList() -> [Stock] {

        let stock = Stock(ticker: searchTerm.uppercased(), quote: Quote.EmptyQuote, match: Match.EmptyMatch)
        return searchTerm.isEmpty ? stockQuoteManager.stocks : stockQuoteManager.stocks.filter {
            print("filtering stock list \(stockQuoteManager.stocks)")
            return $0.symbol.lowercased().contains(searchTerm.lowercased()) }
    }
    
    private func filteredStocks() -> [Quote] {
        return searchTerm.isEmpty ? stockQuoteManager.quotes : stockQuoteManager.quotes.filter {
            print("filtering stock list \(stockQuoteManager.quotes)")
            return $0.symbol.lowercased().contains(searchTerm.lowercased()) }
    }
    
    //  can I write a computed  property  for  the  filteredStocks
//    var filteredStocks:  [Quote] {
//        return searchTerm.isEmpty ? stockQuoteManager.quotes : stockQuoteManager.quotes.filter{
//            $0.symbol.lowercased().contains(searchTerm.lowercased())
//        }
//    }
    
    private func fetchMultipleQuotes(for stocks: [Stock]) {
        stocks.forEach { stock in
            stockQuoteManager.requestAQuote(ticker: stock.symbol) { _ in
                // download  the list - it's @Published var quotes: [Quote] = []
            }
        }
    }
    private func fetchQuotes(for stocks: [Stock]) {
        stocks.forEach { stock in
            stockQuoteManager.requestAQuote(ticker: stock.symbol) { _ in
                // download  the list - it's @Published var quotes: [Quote] = []
            }
        }
    }
    //  old method for an array
    private func fetchData(for symbols: [String]) {
        stockQuoteManager.download(stocks: symbols) { _ in
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
