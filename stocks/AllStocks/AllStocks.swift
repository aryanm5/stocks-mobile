//
//  AllStocks.swift
//  stocks
//
//  Created by Aryan Mittal on 11/25/21.
//

import SwiftUI
import CoreData

struct AllStocks: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @EnvironmentObject private var appData: AppData
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \WatchedStock.id, ascending: false)],
        animation: .default)
    private var watchlist: FetchedResults<WatchedStock>
    
    @State private var searchText: String = ""
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20, pinnedViews: [.sectionHeaders]) {
                Section(
                    header:
                        HStack(alignment: .bottom) {
                            Text("Watchlist")
                                .font(.title3.weight(.heavy))
                                .padding(5)
                                .padding(.horizontal, 5)
                                .background(.ultraThinMaterial)
                                .cornerRadius(10)
                            Spacer()
                        }
                        .padding(.leading, 12)
                        .padding(.top, 20)
                        .padding(.bottom, -15)
                ) {
                    ForEach(appData.stocks.filter { isSearched(stock: $0) && inWatchlist(id: $0.id) }) { stock in
                        NavigationLink(destination: StockView(stock: stock)) {
                            StockItem(stock: stock)
                        }
                        .buttonStyle(.plain)
                        .contextMenu {
                            Button {
                                removeWatchlist(id: stock.id)
                            } label: {
                                Label("Remove from Watchlist", systemImage: "minus.circle.fill")
                            }
                        }
                        .id("\(stock.id)\(inWatchlist(id: stock.id))")
                    }
                    .transition(.scale)
                }
                
                Section(
                    header:
                        HStack(alignment: .bottom) {
                            Text("All Stocks")
                                .font(.title3.weight(.heavy))
                                .padding(5)
                                .padding(.horizontal, 5)
                                .background(.ultraThinMaterial)
                                .cornerRadius(10)
                            Spacer()
                        }
                        .padding(.leading, 12)
                        .padding(.top, 10)
                        .padding(.bottom, -15)
                ) {
                    ForEach(appData.stocks.filter { isSearched(stock: $0) && !inWatchlist(id: $0.id) }) { stock in
                        NavigationLink(destination: StockView(stock: stock)) {
                            StockItem(stock: stock)
                        }
                        .buttonStyle(.plain)
                        .contextMenu {
                            Button {
                                addWatchlist(id: stock.id)
                            } label: {
                                Label("Add to Watchlist", systemImage: "plus.circle.fill")
                            }
                        }
                        .id("\(stock.id)\(inWatchlist(id: stock.id))")
                    }
                    .transition(.scale)
                }
            }
            .padding(.horizontal)
        }
        .searchable(text: $searchText.animation(.spring()))
        .navigationTitle("Stocks")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func isSearched(stock: Stock) -> Bool {
        let searchTerm: String = searchText.filter { !$0.isWhitespace }.lowercased()
        
        if searchTerm.isEmpty {
            return true
        }
        
        return stock.name.filter { !$0.isWhitespace }.lowercased().contains(searchTerm) ||
        stock.ticker.lowercased().contains(searchTerm)
    }
    
    private func inWatchlist(id: String) -> Bool {
        for item in watchlist {
            if item.id == id {
                return true
            }
        }
        return false
    }
    
    private func addWatchlist(id: String) -> Void {
        withAnimation {
            let newItem: WatchedStock = WatchedStock(context: viewContext)
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
    
    private func removeWatchlist(id: String) -> Void {
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

struct AllStocks_Previews: PreviewProvider {
    static var previews: some View {
        AllStocks().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
