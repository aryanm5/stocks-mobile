//
//  StockItem.swift
//  stocks
//
//  Created by Aryan Mittal on 11/20/21.
//

import SwiftUI

struct StockItem: View {
    let stock: Stock
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Text(stock.name)
                .font(.title2)
                .bold()
                .foregroundColor(.white)
                .lineLimit(1)
            Text(stock.ticker)
                .foregroundColor(.white)
        }
        .padding()
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 150,
            maxHeight: .infinity,
            alignment: .topLeading
        )
        .background(LinearGradient(gradient: Gradient(colors: [stock.color1.asColor(), stock.color2.asColor()]), startPoint: .topTrailing, endPoint: .bottomLeading))
        .cornerRadius(15)
    }
}

struct StockItem_Previews: PreviewProvider {
    static var previews: some View {
        StockItem(stock: previewStock)
    }
}
