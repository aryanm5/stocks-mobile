//
//  StockItem.swift
//  stocks
//
//  Created by Aryan Mittal on 11/20/21.
//

import SwiftUI

struct StockItem: View {
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    @AppStorage("colorblind") private var colorblind: Bool = false
    
    let stock: Stock
    
    var body: some View {
        let textColor: Color = colorblind ? (colorScheme == .light ? .white : .black) : .white
        let background: [Color] = colorScheme == .light
        ? [Color(red: 70/255, green: 70/255, blue: 70/255), .black]
        : [Color(red: 180/255, green: 180/255, blue: 180/255), .white]
        
        VStack(alignment: .leading) {
            Spacer()
            Text(stock.name)
                .font(.title2)
                .bold()
                .foregroundColor(textColor)
                .lineLimit(1)
            Text(stock.subtitle)
                .foregroundColor(textColor)
                .font(.system(size: 15))
                .lineLimit(1)
                .minimumScaleFactor(0.8)
        }
        .padding()
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 150,
            maxHeight: .infinity,
            alignment: .topLeading
        )
        .background(
            colorblind
            ? LinearGradient(gradient: Gradient(colors: background), startPoint: .topTrailing, endPoint: .bottomLeading)
            : LinearGradient(gradient: Gradient(colors: [stock.color1.asColor(), stock.color2.asColor()]), startPoint: .topTrailing, endPoint: .bottomLeading)
        )
        .cornerRadius(15)
    }
}

struct StockItem_Previews: PreviewProvider {
    static var previews: some View {
        StockItem(stock: previewStock)
    }
}
