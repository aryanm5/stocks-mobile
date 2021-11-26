//
//  DataModels.swift
//  stocks
//
//  Created by Aryan Mittal on 11/21/21.
//

import Foundation

struct AppData: Codable {
    var stocks: [Stock]
    var news: News
}

struct Stock: Codable {
    let id: String
    let name: String
    let subtitle: String
    let ticker: String
    let desc: String
    let exchange: String
    let max: Int
    let min: Int
    let current: Double
    let realtime: String
    let website: String
    let wiki: String
    let preds: [Double]
}

struct News: Codable {
    let lastUpdated: Int
    let articles: [Article]
}

struct Article: Codable {
    let id: String
    let url: String
    let title: String
    let publisher: String
    let thumbnail: String
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
    realtime: "https://www.google.com/finance/quote/AAPL:NASDAQ",
    website: "https://www.apple.com/",
    wiki: "https://en.m.wikipedia.org/wiki/Apple_Inc.",
    preds: [
        173.12,
        172.39,
        171.79,
        171.05,
        170.65,
        170.87,
    ]
)
