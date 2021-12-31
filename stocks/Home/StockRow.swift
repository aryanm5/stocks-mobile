//
//  StockRow.swift
//  stocks
//
//  Created by Aryan Mittal on 11/26/21.
//

import SwiftUI

struct StockRow: View {
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    @AppStorage("colorblind") private var colorblind: Bool = false
    
    let stock: Stock
    
    var body: some View {
        let textColor: Color = colorblind ? (colorScheme == .light ? .white : .black) : .white

        Text(stock.name)
            .font(.body)
            .foregroundColor(textColor)
            .lineLimit(1)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct StockRow_Previews: PreviewProvider {
    static var previews: some View {
        StockRow(stock: previewStock)
    }
}
