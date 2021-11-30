//
//  StockDetails.swift
//  stocks
//
//  Created by Aryan Mittal on 11/30/21.
//

import SwiftUI

struct StockDetails: View {
    let stock: Stock
    
    var body: some View {
        Text("\(stock.name) Details")
    }
}

struct StockDetails_Previews: PreviewProvider {
    static var previews: some View {
        StockDetails(stock: previewStock)
    }
}
