//
//  ArticleRow.swift
//  stocks
//
//  Created by Aryan Mittal on 12/3/21.
//

import SwiftUI
import BetterSafariView

struct ArticleRow: View {
    let article: Article
    
    @State private var published: String = ""
    @State private var presentingSafariView: Bool = false
    
    var body: some View {
        Button(action: openUrl) {
            HStack(alignment: .top, spacing: 25) {
                VStack(alignment: .leading, spacing: 5) {
                    Text(article.publisher)
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                        .bold()
                        .lineLimit(1)
                    Text(article.title)
                        .bold()
                        .lineLimit(3)
                    Text(published)
                        .foregroundColor(.secondary)
                        .font(.caption2)
                        .bold()
                        .padding(.top, 5)
                }
                AsyncImage(url: URL(string: "https://images.wsj.net/im-444961")!) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Color.gray
                }
                .frame(width: 120, height: 120)
                .cornerRadius(10)
            }
        }
        .padding(.horizontal, 10)
        .contextMenu {
            Button {
                openUrl()
            } label: {
                Label("Open Link", systemImage: "safari")
            }
            Button {
                copyToClipboard()
            } label: {
                Label("Copy Link", systemImage: "link")
            }
            Button {
                share()
            } label: {
                Label("Share Story", systemImage: "square.and.arrow.up")
            }
        }
        .buttonStyle(PlainButtonStyle())
        .onAppear {
            setPublished()
        }
        .safariView(isPresented: $presentingSafariView) {
            SafariView(
                url: article.url,
                configuration: SafariView.Configuration(
                    entersReaderIfAvailable: true
                )
            )
        }
    }
    
    private func openUrl() -> Void {
        presentingSafariView = true
    }
    
    private func copyToClipboard() -> Void {
        UIPasteboard.general.string = article.url.absoluteString
    }
    
    private func share() -> Void {
        let shareActivity: UIActivityViewController = UIActivityViewController(activityItems: [article.url], applicationActivities: nil)
        
        if let vc: UIViewController = UIApplication.shared.windows.first?.rootViewController {
            shareActivity.popoverPresentationController?.sourceView = vc.view
            //Setup share activity position on screen on bottom center
            shareActivity.popoverPresentationController?.sourceRect = CGRect(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height, width: 0, height: 0)
            shareActivity.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.down
            vc.present(shareActivity, animated: true, completion: nil)
        }
    }
    
    private func setPublished() -> Void {
        if published.isEmpty {
            let updateDate: Date = Date(timeIntervalSince1970: article.publishDate)
            
            let formatter: RelativeDateTimeFormatter = RelativeDateTimeFormatter()
            formatter.unitsStyle = .full
            
            published = formatter.localizedString(for: updateDate, relativeTo: Date())
        }
    }
}

struct ArticleRow_Previews: PreviewProvider {
    static var previews: some View {
        ArticleRow(article: previewArticle)
    }
}
