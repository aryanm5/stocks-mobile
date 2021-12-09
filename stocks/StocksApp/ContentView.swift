//
//  ContentView.swift
//  stocks
//
//  Created by Aryan Mittal on 11/15/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @StateObject private var appData: AppData = AppData()
    
    @State private var loading: Bool = true
    @State private var isError: Bool = false
    
    var body: some View {
        NavigationView {
            if isError {
                Text("Something went wrong.")
                    .foregroundColor(.secondary)
            } else if loading {
                ProgressView()
            } else {
                Home()
                    .environmentObject(appData)
            }
        }
        .task {
            await loadData()
        }
    }
    
    private func loadData() async -> Void {
        
        guard let url: URL = URL(string: "https://api.mittaldev.com/stocks-dev/getStocks") else {
            isError = true
            return
        }
        
        do {
            let (response, _): (Data, URLResponse) = try await URLSession.shared.data(from: url)
            let decodedResponse: Response = try JSONDecoder().decode(Response.self, from: response)
            DispatchQueue.main.async {
                appData.stocks = decodedResponse.stocks
                appData.news = decodedResponse.news
            }
            loading = false
        } catch let jsonError as NSError {
            isError = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
