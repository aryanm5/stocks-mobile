//
//  CustomizeView.swift
//  stocks
//
//  Created by Aryan Mittal on 12/5/21.
//

import SwiftUI

struct CustomizeView: View {
    @AppStorage("laserMode") var laserMode: Bool = false
    
    var body: some View {
        List {
            Section {
                VStack(alignment: .leading) {
                    Toggle("Laser Mode", isOn: $laserMode)
                    Text("Special laser effect for graphs")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
            }
            Section {
                VStack {
                    Text("App Icon")
                }
            }
        }
        .navigationTitle("Customize")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CustomizeView_Previews: PreviewProvider {
    static var previews: some View {
        CustomizeView().preferredColorScheme(.dark)
    }
}
