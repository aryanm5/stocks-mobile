//
//  StockRow.swift
//  stocks
//
//  Created by Aryan Mittal on 11/26/21.
//

import SwiftUI

struct StockRow: View {
    let stock: Stock
    
    var body: some View {
        Text(stock.name)
            .font(.body)
            .foregroundColor(.white)
            .lineLimit(1)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct StockRow_Previews: PreviewProvider {
    static var previews: some View {
        StockRow(stock: previewStock)
    }
}
