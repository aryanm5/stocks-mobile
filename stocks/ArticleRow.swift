//
//  ArticleRow.swift
//  stocks
//
//  Created by Aryan Mittal on 12/3/21.
//

import SwiftUI

struct ArticleRow: View {
    let article: Article
    
    @State private var published: String = ""
    
    var body: some View {
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
        .onAppear {
            setPublished()
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
