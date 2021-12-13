//
//  StockView.swift
//  stocks
//
//  Created by Aryan Mittal on 11/29/21.
//

import SwiftUI
import RHLinePlot

struct DateRange: Identifiable {
    let id: String
    let name: String
}

struct StockView: View {
    @AppStorage("laserMode") private var laserMode: Bool = false
    
    let stock: Stock
    
    let green: Color = Color(red: 33/255, green: 206/255, blue: 153/255)
    let red: Color = Color(red: 244/255, green: 85/255, blue: 49/255)
    
    let dateRanges: [DateRange] = [DateRange(id: "week", name: "1W"), DateRange(id: "month", name: "1M"), DateRange(id: "quarter", name: "3M"), DateRange(id: "half", name: "6M"), DateRange(id: "year", name: "1Y")]
    
    let today: Date = Date()
    
    @State private var currentIndex: Int? = nil
    @State private var dateRange: String = "year"
    
    var body: some View {
        List {
            Section(footer: Text("Disclaimer: This is a prediction and may not be accurate.")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                        .bold()
                        .listRowBackground(Color.clear)
                        .frame(maxWidth: .infinity, alignment: .center)) {
                StockHeaderAndPrice(stock: stock, currentIndex: currentIndex ?? (stock.segments[dateRange]! - 1))
                
                Picker("Time Range", selection: $dateRange) {
                    ForEach(dateRanges) {
                        Text($0.name)
                    }
                }
                .pickerStyle(.segmented)
                
                ZStack {
                    RHInteractiveLinePlot(
                        values: Array(stock.preds.prefix(stock.segments[dateRange]!)),
                        didSelectValueAtIndex: { index in
                            currentIndex = index
                        },
                        valueStickLabel: { _ in
                            Text(Date(timeIntervalSince1970: stock.dates[currentIndex ?? stock.segments[dateRange]! - 1]).toStringGMT(format: "MMM d, yyyy"))
                        }
                    )
                        .frame(maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
                        .foregroundColor(stock.preds.first! <= stock.preds[stock.segments[dateRange]! > stock.preds.count ? stock.preds.count - 1 : stock.segments[dateRange]! - 1] ? green : red)
                    
                    HStack {
                        Text(String(format: "%.0f", stock.preds.first!))
                        Spacer()
                        Text(String(format: "%.0f", stock.preds[stock.segments[dateRange]! > stock.preds.count ? stock.preds.count - 1 : stock.segments[dateRange]! - 1]))
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .allowsHitTesting(false)
                }
                .padding(.bottom, -15)
                
                HStack {
                    Text("Today")
                    Spacer()
                    Text(Date(timeIntervalSince1970: stock.dates[stock.segments[dateRange]! - 1]).toStringGMT(format: "MMM yyyy"))
                }
                .font(.caption)
                .foregroundColor(.secondary)
            }
            .listRowSeparator(.hidden)
            
            StockDetails(stock: stock)
        }
        .navigationTitle(stock.name)
        .navigationBarTitleDisplayMode(.inline)
        .environment(\.rhLinePlotConfig, RHLinePlotConfig.default.custom(f: { c in
            c.useLaserLightLinePlotStyle = laserMode
        }))
    }
}

struct StockView_Previews: PreviewProvider {
    static var previews: some View {
        StockView(stock: previewStock)
    }
}
