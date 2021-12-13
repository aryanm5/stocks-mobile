//
//  OnboardingItem.swift
//  stocks
//
//  Created by Aryan Mittal on 12/13/21.
//

import SwiftUI

enum OnboardingItem: Identifiable, CaseIterable {
    case future, watch, news
    
    var id: String {
        switch self {
        case .future: return "future"
        case .watch: return "watch"
        case .news: return "news"
        }
    }
    
    var title: String {
        switch self {
        case .future: return "Stock Predictions"
        case .watch: return "Add to Watchlist"
        case .news: return "Ticker News"
        }
    }
    
    var subtitle: String {
        switch self {
        case .future: return "Look into the future with machine learning."
        case .watch: return "Add your favorite stocks to your watchlist."
        case .news: return "Read daily news to stay ahead of the game."
        }
    }
    
    var systemImageName: String {
        switch self {
        case .future: return "chart.xyaxis.line"
        case .watch: return "bookmark.fill"
        case .news: return "newspaper.fill"
        }
    }
    
    var color: Color {
        switch self {
        case .future: return .blue
        case .watch: return .green
        case .news: return .pink
        }
    }
}

