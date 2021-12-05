//
//  DataModels.swift
//  stocks
//
//  Created by Aryan Mittal on 11/21/21.
//

import SwiftUI
import Foundation

final class AppData: ObservableObject {
    @Published var stocks: [Stock] = [Stock]()
    @Published var news: News = News(lastUpdated: 0, articles: [Article]())
}

struct Response: Codable {
    let stocks: [Stock]
    let news: News
}

struct Rgb: Codable {
    let r: Double
    let g: Double
    let b: Double
    
    func asColor() -> Color {
        Color(red: r / 255, green: g / 255, blue: b / 255)
    }
}

struct Stock: Codable, Identifiable {
    let id: String
    let name: String
    let subtitle: String
    let ticker: String
    let desc: String
    let exchange: String
    let max: Int
    let min: Int
    let current: Double
    let realtime: URL
    let website: URL
    let wiki: URL
    let preds: [CGFloat]
    let color1: Rgb
    let color2: Rgb
}

struct News: Codable {
    let lastUpdated: TimeInterval
    let articles: [Article]
}

struct Article: Codable, Identifiable {
    let id: String
    let url: URL
    let title: String
    let publisher: String
    let thumbnail: URL
    let publishDate: TimeInterval
    let keywords: [String]
    let tickers: [String]
}

let previewStock: Stock = Stock(
    id: "apple",
    name: "Apple",
    subtitle: "Technology company",
    ticker: "AAPL",
    desc: "Apple Inc. designs, manufactures, and markets smartphones, personal computers, tablets, wearables, and accessories, and sells a variety of related services. The company's products include iPhone, Mac, iPad, AirPods, Apple TV, Apple Watch, Apple Music, Apple Pay, and more.",
    exchange: "NASDAQ",
    max: 848,
    min: 33,
    current: 180.0,
    realtime: URL(string:"https://www.google.com/finance/quote/AAPL:NASDAQ")!,
    website: URL(string: "https://www.apple.com/")!,
    wiki: URL(string:"https://en.m.wikipedia.org/wiki/Apple_Inc.")!,
    preds: [
        173.12,
        172.39,
        171.79,
        171.05,
        170.65,
        170.87,
    ],
    color1: Rgb(r: 0, g: 0, b: 0),
    color2: Rgb(r: 103, g: 103, b: 103)
)

let previewArticle: Article = Article(
    id: "articleId",
    url: URL(string: "https://google.com")!,
    title: "Google Article",
    publisher: "The Previewer",
    thumbnail: URL(string: "https://images.wsj.net/im-444961")!,
    publishDate: 1637911800,
    keywords: ["google", "news", "wow"],
    tickers: ["GOOGL"]
)
