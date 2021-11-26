//
//  ContentView.swift
//  stocks
//
//  Created by Aryan Mittal on 11/15/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \WatchedStock.id, ascending: false)],
        animation: .default)
    private var watchlist: FetchedResults<WatchedStock>
    
    @State private var stocks: [Stock] = [Stock]()
    @State private var news: [Article] = [Article]()
    @State private var loading: Bool = true
    
    let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20),
    ]
    
    var body: some View {
        NavigationView {
            if loading {
                ProgressView()
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        Section {
                            ForEach(stocks, id: \.self.id) { item in
                                if inWatchlist(id: item.id) {
                                    NavigationLink(destination: Text(item.name)) {
                                        StockItem(stock: item)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    .contextMenu {
                                        Button {
                                            removeWatchlist(id: item.id)
                                        } label: {
                                            Label("Remove from Watchlist", systemImage: "minus.circle.fill")
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.bottom, 25)
                        
                        Section(
                            header:
                                HStack(alignment: .bottom) {
                                    Text("All Stocks").font(Font.title3.weight(.heavy))
                                    Spacer()
                                }
                                .padding(.leading, 20)
                                .padding(.bottom, -10)
                        ) {
                            ForEach(Array(stocks.suffix(4)), id: \.self.id) { item in
                                if !inWatchlist(id: item.id) {
                                    NavigationLink(destination: Text(item.name)) {
                                        StockItem(stock: item)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    .contextMenu {
                                        Button {
                                            addWatchlist(id: item.id)
                                        } label: {
                                            Label("Add to Watchlist", systemImage: "plus.circle.fill")
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Stockscast")
            }
        }
        .task {
            await loadData()
        }
    }
    
    func loadData() async {
        print("Loading data!")
        
        guard let url = URL(string: "https://api.mittaldev.com/stocks-dev/getStocks") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (response, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode(AppData.self, from: response)
            stocks = decodedResponse.stocks
            loading = false
            // set news
            
        } catch let jsonError as NSError {
            print("Invalid data: \(jsonError)")
        }
    }
    
    private func inWatchlist(id: String) -> Bool {
        for item in watchlist {
            if item.id == id {
                return true
            }
        }
        return false
    }
    
    private func addWatchlist(id: String) {
        withAnimation {
            let newItem = WatchedStock(context: viewContext)
            newItem.id = id
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func removeWatchlist(id: String) {
        withAnimation {
            watchlist.filter { $0.id == id }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
