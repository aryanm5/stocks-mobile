//
//  StockView.swift
//  stocks
//
//  Created by Aryan Mittal on 11/29/21.
//

import SwiftUI
import RHLinePlot

struct DateRange: Identifiable {
    let id: Int
    let name: String
}

struct StockView: View {
    @AppStorage("laserMode") var laserMode: Bool = false
    
    let stock: Stock
    
    let green: Color = Color(red: 33/255, green: 206/255, blue: 153/255)
    let red: Color = Color(red: 244/255, green: 85/255, blue: 49/255)
    
    let dateRanges: [DateRange] = [DateRange(id: 30, name: "1M"), DateRange(id: 90, name: "3M"), DateRange(id: 180, name: "6M"), DateRange(id: 365, name: "1Y"), DateRange(id: 730, name: "2Y"), DateRange(id: 1095, name: "3Y")]
    
    let today: Date = Date()
    
    @State private var currentIndex: Int? = nil
    @State private var dateRange: Int = 365
    
    var body: some View {
        List {
            VStack {
            StockHeaderAndPrice(stock: stock, currentIndex: currentIndex ?? (dateRange - 1))
            
                Picker("Time Range", selection: $dateRange) {
                    ForEach(dateRanges) {
                        Text($0.name)
                    }
                }
                .pickerStyle(.segmented)
                
                ZStack {
                    RHInteractiveLinePlot(
                        values: Array(stock.preds.prefix(dateRange)),
                        didSelectValueAtIndex: { index in
                            currentIndex = index
                        },
                        valueStickLabel: { _ in
                            Text(Calendar.current.date(byAdding: .day, value: currentIndex ?? (dateRange - 1), to: today)!.formatted(.dateTime.year().month().day()))
                        }
                    )
                        .frame(maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
                        .foregroundColor(stock.preds.first! <= stock.preds[dateRange > stock.preds.count ? stock.preds.count - 1 : dateRange - 1] ? green : red)
                    
                    HStack {
                        Text(String(format: "%.0f", stock.preds.first!))
                        Spacer()
                        Text(String(format: "%.0f", stock.preds[dateRange > stock.preds.count ? stock.preds.count - 1 : dateRange - 1]))
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .allowsHitTesting(false)
                }
                
                HStack {
                    Text("Today")
                    Spacer()
                    Text(Calendar.current.date(byAdding: .day, value: dateRange, to: today)!.formatted(.dateTime.year().month()))
                }
                .font(.caption)
                .foregroundColor(.secondary)
                .offset(y: -10)
            }
            
            StockDetails(stock: stock)
        }
        .navigationTitle(stock.name)
        .navigationBarTitleDisplayMode(.inline)
        .environment(\.rhLinePlotConfig, RHLinePlotConfig.default.custom(f: { c in
            c.useLaserLightLinePlotStyle = laserMode//colorScheme == .dark
        }))
    }
}

struct StockView_Previews: PreviewProvider {
    static var previews: some View {
        StockView(stock: previewStock)
    }
}
