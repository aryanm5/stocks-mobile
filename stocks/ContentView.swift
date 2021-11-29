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
    
    @StateObject var appData: AppData = AppData()
    
    @State var loading: Bool = true
    
    var body: some View {
        NavigationView {
            if loading {
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
    
    func loadData() async -> Void {
        
        guard let url: URL = URL(string: "https://api.mittaldev.com/stocks-dev/getStocks") else {
            print("Invalid URL")
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
            print("Invalid data: \(jsonError)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
