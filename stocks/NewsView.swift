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
        //List {
        ForEach(appData.news.articles) { article in
            ArticleRow(article: article)
            ArticleRow(article: article)
            ArticleRow(article: article)
            ArticleRow(article: article)
            ArticleRow(article: article)
            ArticleRow(article: article)
        }
        //}
        //.padding(.top)
        //.padding(.horizontal, 10)
    }
}


struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
