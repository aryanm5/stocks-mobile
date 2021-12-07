//
//  NewsView.swift
//  stocks
//
//  Created by Aryan Mittal on 12/3/21.
//

import SwiftUI

struct NewsView: View {
    @EnvironmentObject private var appData: AppData
    
    var body: some View {
        List {
            ForEach(appData.news.articles) { article in
                ArticleRow(article: article)
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
        .padding(.top, -5)
    }
}


struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
