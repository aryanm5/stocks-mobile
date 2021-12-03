//
//  StockDetails.swift
//  stocks
//
//  Created by Aryan Mittal on 11/30/21.
//

import SwiftUI
import BetterSafariView


struct StockDetails: View {
    let stock: Stock
    
    @State private var activeUrl: URL? = nil
        
    var body: some View {
        if !stock.preds.isEmpty {
            Section(header: Text("Prices")) {
                HStack {
                    VStack(spacing: 5) {
                        PriceRow(name: "First", value: stock.preds.first!, days: 0)
                        PriceRow(name: "Last", value: stock.preds.last!, days: stock.preds.count)
                    }
                    Divider()
                        .padding(.horizontal, 5)
                    VStack(spacing: 5) {
                        PriceRow(name: "High", value: stock.preds[stock.max], days: stock.max)
                        PriceRow(name: "Low", value: stock.preds[stock.min], days: stock.min)
                    }
                }
                .padding(.vertical, 5)
            }
        }
        Section(header: Text("About")) {
            Text(stock.desc)
                .padding(.vertical, 5)
                .safariView(item: $activeUrl) { activeUrl in
                    SafariView(
                        url: activeUrl,
                        configuration: SafariView.Configuration(
                            entersReaderIfAvailable: true
                        )
                    )
                }
        }
        Section(header: Text("Links")) {
            StockLink(url: stock.realtime, display: "Google Finance", openLink: openLink)
            StockLink(url: stock.wiki, display: "Wikipedia", openLink: openLink)
            StockLink(url: stock.website, display: stock.website.absoluteString.components(separatedBy: "://")[1].components(separatedBy: "/")[0].replacingOccurrences(of: "www.", with: "").capitalizedFirst(), openLink: openLink)
        }
    }
    
    private func openLink(url: URL) -> Void {
        activeUrl = url
    }
}

private func copyToClipboard(url: String) -> Void {
    UIPasteboard.general.string = url
}

private func share(url: URL) -> Void {
    let shareActivity: UIActivityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
    
    if let vc: UIViewController = UIApplication.shared.windows.first?.rootViewController {
        shareActivity.popoverPresentationController?.sourceView = vc.view
        //Setup share activity position on screen on bottom center
        shareActivity.popoverPresentationController?.sourceRect = CGRect(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height, width: 0, height: 0)
        shareActivity.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.down
        vc.present(shareActivity, animated: true, completion: nil)
    }
}

private struct PriceRow: View {
    let name: String
    let value: Double
    let days: Int
    
    var body: some View {
        HStack {
            Text(name)
                .foregroundColor(.secondary)
            Spacer()
            VStack(alignment: .trailing) {
                Text(String(format: "%.2f", value))
                    .font(.system(size: 14).monospacedDigit())
            }
        }
        .font(.system(size: 14))
    }
}

private struct StockLink: View {
    let url: URL
    let display: String
    let openLink: (_ url: URL) -> Void
    
    var body: some View {
        Button(display) {
            openLink(url)
        }
        .contextMenu {
            Button {
                openLink(url)
            } label: {
                Label("Open Link", systemImage: "safari")
            }
            Button {
                copyToClipboard(url: url.absoluteString)
            } label: {
                Label("Copy Link", systemImage: "doc.on.doc")
            }
            Button {
                share(url: url)
            } label: {
                Label("Share...", systemImage: "square.and.arrow.up")
            }
        }
    }
}

extension String {
    func capitalizedFirst() -> String {
        prefix(1).capitalized + dropFirst()
    }
}

struct StockDetails_Previews: PreviewProvider {
    static var previews: some View {
        StockDetails(stock: previewStock)
    }
}
