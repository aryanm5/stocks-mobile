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
    
    @EnvironmentObject var appData: AppData
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \WatchedStock.id, ascending: false)],
        animation: .default)
    private var watchlist: FetchedResults<WatchedStock>
    
    let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20),
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                Section {
                    ForEach(appData.stocks, id: \.self.id) { item in
                        NavigationLink(destination: Text(item.name)) {
                            StockItem(stock: item)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .contextMenu {
                            if inWatchlist(id: item.id) {
                                Button(role: .destructive) {
                                    removeWatchlist(id: item.id)
                                } label: {
                                    Label("Remove from Watchlist", systemImage: "minus.circle.fill")
                                }
                            } else {
                                Button {
                                    addWatchlist(id: item.id)
                                } label: {
                                    Label("Add to Watchlist", systemImage: "plus.circle.fill")
                                }
                            }
                        }
                    }
                    .padding(.bottom, 25)
                }
            }
            .navigationTitle("All Stocks")
            .navigationBarTitleDisplayMode(.inline)
        }
        .padding()
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

struct AllStocks_Previews: PreviewProvider {
    static var previews: some View {
        AllStocks().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

