//
//  AboutView.swift
//  stocks
//
//  Created by Aryan Mittal on 12/5/21.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 5) {
                Text("Stockscast is an AI-based financial tool that provides insights about future market trends.")
                    .padding()
                    .padding(.top, 15)
                
                Text("Our specialized machine learning model analyzes previous stock behavior to reliably predict future trends. The model is retrained every day to maintain accurate predictions.")
                    .padding()
                
                Text("Get started by adding your favorite stocks to your Watchlist.")
                    .padding()
                
                Text("Aryan Mittal\nAryav Nagar\nAnshil Patel")
                    .padding()
            }
        }
        .navigationTitle("About the App")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
