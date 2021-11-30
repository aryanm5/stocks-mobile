//
//  StockHeaderAndPrice.swift
//  stocks
//
//  Created by Aryan Mittal on 11/30/21.
//

import SwiftUI
import MovingNumbersView

struct StockHeaderAndPrice: View {
    let stock: Stock
    let currentIndex: Int
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(stock.ticker)
                    .font(.title2.weight(.heavy))
                    .foregroundColor(.secondary)
                HStack(spacing: 2) {
                    Text("$")
                    MovingNumbersView(
                        number: Double(stock.preds[currentIndex >= stock.preds.count ? stock.preds.count - 1 : currentIndex]),
                        numberOfDecimalPlaces: 2,
                        fixedWidth: 100,
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
            Spacer()
        }
        .padding(.horizontal, 5)
        .padding(.vertical)
    }
}

struct StockHeaderAndPrice_Previews: PreviewProvider {
    static var previews: some View {
        StockHeaderAndPrice(stock: previewStock, currentIndex: 0)
    }
}
