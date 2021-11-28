//
//  Home.swift
//  stocks
//
//  Created by Aryan Mittal on 11/26/21.
//

import SwiftUI

struct Home: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \WatchedStock.id, ascending: false)],
        animation: .default)
    private var watchlist: FetchedResults<WatchedStock>
    
    @EnvironmentObject var appData: AppData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            List {
                VStack {
                    Text("Last Updated")
                        .foregroundColor(.secondary)
                        .font(.subheadline)
                        .padding(.bottom, -5)
                    Text("Yesterday")
                        .font(.title2)
                        .bold()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(.thickMaterial)
                .cornerRadius(15)
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets())
                
                Section(header: Text("Watchlist")) {
                    ForEach(watchlist.map {
                        stock in appData.stocks.first(where: { stock.id == $0.id }) ?? previewStock
                    }, id: \.self.id) { stock in
                        NavigationLink(destination: Text(stock.name)) {
                            StockRow(stock: stock)
                                .contextMenu {
                                    Button {
                                        removeWatchlist(id: stock.id)
                                    } label: {
                                        Label("Remove from Watchlist", systemImage: "minus.circle.fill")
                                    }
                                }
                        }
                        .padding()
                        .background(LinearGradient(gradient: Gradient(colors: [stock.color1.asColor(), stock.color2.asColor()]), startPoint: .topTrailing, endPoint: .bottomLeading))
                        .cornerRadius(10)
                        .padding(.bottom, 10)
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets())
                    }
                    .onDelete(perform: deleteItems)
                    .listRowBackground(Color.clear)
                    
                    ZStack {
                        HStack {
                            Spacer()
                            Text("View All")
                                .bold()
                            Image(systemName: "arrow.right")
                            Spacer()
                        }
                        .foregroundColor(.blue)
                        
                        NavigationLink(destination: AllStocks().environmentObject(appData)) {
                            EmptyView()
                        }.buttonStyle(PlainButtonStyle())
                    }
                    .listRowBackground(Color.clear)
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle("Stockscast")
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
    
    private func deleteItems(offsets: IndexSet) -> Void {
        withAnimation {
            offsets.map { watchlist[$0] }.forEach(viewContext.delete)
            
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

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
