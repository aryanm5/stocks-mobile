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
        Section(header: Text("Links")) {
            StockLink(url: stock.realtime, display: "Google Finance", openLink: openLink)
            StockLink(url: stock.wiki, display: "Wikipedia", openLink: openLink)
            StockLink(url: stock.website, display: stock.website.absoluteString.components(separatedBy: "://")[1].components(separatedBy: "/")[0].replacingOccurrences(of: "www.", with: "").capitalizedFirst(), openLink: openLink)
        }
        Section(header: Text("About \(stock.name)")) {
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

struct StockLink: View {
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
