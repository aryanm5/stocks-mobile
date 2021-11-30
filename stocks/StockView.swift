//
//  StockView.swift
//  stocks
//
//  Created by Aryan Mittal on 11/29/21.
//

import SwiftUI
import RHLinePlot
import MovingNumbersView

struct DateRange: Identifiable {
    let id: Int
    let name: String
}

struct StockView: View {
    @Environment(\.colorScheme) var colorScheme
    
    let stock: Stock
    
    let green: Color = Color(red: 33/255, green: 206/255, blue: 153/255)
    let red: Color = Color(red: 244/255, green: 85/255, blue: 49/255)
    
    let dateRanges: [DateRange] = [DateRange(id: 30, name: "1M"), DateRange(id: 90, name: "3M"), DateRange(id: 180, name: "6M"), DateRange(id: 365, name: "1Y"), DateRange(id: 730, name: "2Y"), DateRange(id: 900, name: "3Y")]
    
    let today: Date = Date()
    
    @State var currentIndex: Int? = nil
    @State var dateRange: Int = 900
    
    var body: some View {
        ScrollView {
            stockHeaderAndPrice()
            
            VStack {
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
                        .foregroundColor(stock.preds[0] <= stock.preds[dateRange > stock.preds.count ? stock.preds.count - 1 : dateRange - 1] ? green : red)
                    
                    HStack {
                        Text(String(format: "%.0f", stock.preds[0]))
                        Spacer()
                        Text(String(format: "%.0f", stock.preds[dateRange > stock.preds.count ? stock.preds.count - 1 : dateRange - 1]))
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .allowsHitTesting(false)
                }
                
                HStack {
                    Text("Today")
                    //.padding(5)
                    //.padding(.horizontal, 5)
                    //.background(.thinMaterial)
                    //.clipShape(Capsule())
                    Spacer()
                    Text(Calendar.current.date(byAdding: .day, value: dateRange, to: today)!.formatted(.dateTime.year().month()))
                }
                .font(.caption)
                .foregroundColor(.secondary)
                .offset(y: -10)
            }
        }
        .padding(.horizontal)
        .navigationTitle(stock.name)
        .navigationBarTitleDisplayMode(.inline)
        .environment(\.rhLinePlotConfig, RHLinePlotConfig.default.custom(f: { c in
            c.useLaserLightLinePlotStyle = colorScheme == .dark
        }))
    }
    
    func stockHeaderAndPrice() -> some View {
        return HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(stock.ticker)
                    .font(.title2.weight(.heavy))
                    .foregroundColor(.secondary)
                buildMovingPriceLabel()
            }
            Spacer()
        }
        .padding(.horizontal, 5)
        .padding(.vertical)
    }
    
    func buildMovingPriceLabel() -> some View {
        let currentIndex = self.currentIndex ?? (dateRange - 1)
        return HStack(spacing: 2) {
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
}

struct StockView_Previews: PreviewProvider {
    static var previews: some View {
        StockView(stock: previewStock)
    }
}
