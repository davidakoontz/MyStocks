// SearchView.swift

import SwiftUI

// Stock Symbol search  sheet -  uses Play button to execute
struct SearchView: View {
    
    @Environment(\.dismiss) private var dismiss     // iOS 15
    @State private var searchTerm: String = ""
    
    @ObservedObject var searchManager = SearchManager()
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.8)        // gray background
            VStack {                        //  top  drag bar indicator
                Capsule()
                    .fill(Color.gray)
                    .frame(width: 50, height: 4)
                    .padding(10)
                Spacer()
            }
            .edgesIgnoringSafeArea(.top)
            VStack {
               
                HStack {
                    SearchTextView(searchTerm: $searchTerm)
                    // Play button to make API call
                    Button(action: {
                        print("\nSearch term is: \(searchTerm)")
                        searchManager.searchStocks(searchTerm: searchTerm)
                    }) {
                        Image(systemName: "arrowtriangle.right.circle.fill")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                }
                Spacer()
                
                ScrollView {
                    // matches is a Published property - a list of BestMatches
                    ForEach(searchManager.matches) { match in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(match.symbol)
                                    .font(.title)
                                    .bold()
                                
                                Text(match.type)
                                    .font(.body)
                            }
                            Spacer()
                            Text(match.name)
                            Spacer()
                            Button(action: {
                                UserDefaultsManager.shared.set(match: match)      // was item.symbol a  String
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .font(.title)
                            }
                        }.foregroundColor(.white)
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .frame(height: 1)
                    }
                }
            }
            .padding(.top, 50)
            .padding(.horizontal, 16)
            
        }.edgesIgnoringSafeArea(.all)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
