//
//  StocksApp.swift
//  stocks
//
//  Created by Aryan Mittal on 11/15/21.
//

import SwiftUI

@main
struct stocksApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
