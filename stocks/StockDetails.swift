//
//  StockDetails.swift
//  stocks
//
//  Created by Aryan Mittal on 11/30/21.
//

import SwiftUI
import BetterSafariView

struct StockUrl: Identifiable {
    let id: String
    let url: URL
    let display: String
}

struct StockDetails: View {
    let stock: Stock
    
    //@State private var presentingSafariView: Bool = false
    
    @State private var showRealtime: Bool = false {
        didSet {
            if showRealtime {
                showWiki = false
                showWebsite = false
            }
        }
    }
    @State private var showWiki: Bool = false {
        didSet {
            if showWiki {
                showRealtime = false
                showWebsite = false
            }
        }
    }
    @State private var showWebsite: Bool = false {
        didSet {
            if showWebsite {
                showRealtime = false
                showWiki = false
            }
        }
    }
    
    //@State private var activeUrl: URL? = nil
    /* {
        didSet {
            print("activeUrl was set to \(activeUrl ?? "nil")")
            if activeUrl != nil {
                presentingSafariView = true
            }
        }
    }*/
    
    var body: some View {
        
        /*let showSafari = Binding<Bool>(
            get: { activeUrl == nil },
            set: {
                if !$0 {
                    activeUrl = nil
                }
            }
        )*/
        
        return Group {
            Section(header: Text("About \(stock.name)")) {
                Text(stock.desc)
                //.font(.system(size: 14))
                    .padding(.vertical, 5)
                    .safariView(isPresented: $showRealtime) {
                        SafariView(
                            url: stock.realtime
                        )
                    }
                    .safariView(isPresented: $showWiki) {
                        SafariView(
                            url: stock.wiki,
                            configuration: SafariView.Configuration(
                                entersReaderIfAvailable: true
                            )
                        )
                    }
                    .safariView(isPresented: $showWebsite) {
                        SafariView(
                            url: stock.website
                        )
                    }
            }
            Section(header: Text("Links")) {
                ForEach(urlTypes()) { stockUrl in
                    Button(stockUrl.display) {
                        openLink(id: stockUrl.id, url: stockUrl.url)
                    }
                    .contextMenu {
                        Button {
                            openLink(id: stockUrl.id, url: stockUrl.url)
                        } label: {
                            Label("Open Link", systemImage: "safari")
                        }
                        Button {
                            copyToClipboard(url: stockUrl.url.absoluteString)
                        } label: {
                            Label("Copy Link", systemImage: "doc.on.doc")
                        }
                        Button {
                            share(url: stockUrl.url)
                        } label: {
                            Label("Share...", systemImage: "square.and.arrow.up")
                        }
                    }
                }
            }
        }
    }
    
    private func urlTypes() -> [StockUrl] {
        [
            StockUrl(id: "realtime", url: stock.realtime, display: "Google Finance"),
            StockUrl(id: "wiki", url: stock.wiki, display: "Wikipedia"),
            StockUrl(id: "website", url: stock.website, display: stock.website.absoluteString.components(separatedBy: "://")[1].replacingOccurrences(of: "www.", with: "").capitalizedFirst()),
        ]
    }
    
    private func openLink(id: String,url: URL) -> Void {
        switch id {
            case "realtime": showRealtime = true
            case "wiki": showWiki = true
            case "website": showWebsite = true
            default: break
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
