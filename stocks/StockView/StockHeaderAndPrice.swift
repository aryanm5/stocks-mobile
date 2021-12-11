//
//  StockHeaderAndPrice.swift
//  stocks
//
//  Created by Aryan Mittal on 11/30/21.
//

import SwiftUI
import MovingNumbersView

struct StockHeaderAndPrice: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \WatchedStock.id, ascending: false)],
        animation: .default)
    private var watchlist: FetchedResults<WatchedStock>
    
    let stock: Stock
    let currentIndex: Int
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 4) {
                Text(stock.ticker)
                    .font(.title2.weight(.heavy))
                    .foregroundColor(.secondary)
                HStack(spacing: 2) {
                    Text("$")
                    MovingNumbersView(
                        number: Double(stock.preds[currentIndex >= stock.preds.count ? stock.preds.count - 1 : currentIndex]),
                        numberOfDecimalPlaces: 2,
                        fixedWidth: 180,
                        verticalDigitSpacing: 0,
                        animationDuration: 0.3
                    ) { digit in
                        Text(digit)
                    }.mask(LinearGradient(
                        gradient: Gradient(stops: [
                            Gradient.Stop(color: .clear, location: 0),
                            Gradient.Stop(color: .black, location: 0.2),
                            Gradient.Stop(color: .black, location: 0.8),
                            Gradient.Stop(color: .clear, location: 1.0)]),
                        startPoint: .top,
                        endPoint: .bottom))
                }
                .font(.title.weight(.heavy))
            }
            HStack {
                Spacer()
                if !inWatchlist() {
                    Button(action: addWatchlist) {
                        HStack(spacing: 5) {
                            Image(systemName: "plus")
                            Text("Watch")
                                .bold()
                        }
                    }
                    .buttonStyle(.plain)
                    .font(.system(size: 14))
                    .foregroundColor(.white)
                    .padding(5)
                    .padding(.horizontal, 5)
                    .background(.blue)
                    .clipShape(Capsule())
                }
            }
        }
        .padding(.horizontal, 5)
        .padding(.vertical)
    }
    
    private func inWatchlist() -> Bool {
        for item in watchlist {
            if item.id == stock.id {
                return true
            }
        }
        return false
    }
    
    private func addWatchlist() -> Void {
        withAnimation {
            let newItem: WatchedStock = WatchedStock(context: viewContext)
            newItem.id = stock.id
            
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

struct StockHeaderAndPrice_Previews: PreviewProvider {
    static var previews: some View {
        StockHeaderAndPrice(stock: previewStock, currentIndex: 0)
    }
}
