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
            }
            
            ForEach(Person.allCases) { person in
                PersonView(person: person)
            }
        }
        .navigationTitle("About the App")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PersonView: View {
    let person: Person
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            HStack {
                Image(systemName: person.iconName)
                    .font(.system(size: 25))
                VStack(alignment: .leading, spacing: 0) {
                    Text(person.name)
                        .font(.title3)
                        .bold()
                    Text(person.role)
                        .font(.callout)
                        .foregroundColor(.secondary)
                        .bold()
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                }
            }
            Text(person.desc)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .padding(.vertical, 5)
    }
}

enum Person: CaseIterable, Identifiable {
    case aryan, aryav, anshil
    
    var id: String {
        switch self {
        case .aryan: return "aryan"
        case .aryav: return "aryav"
        case .anshil: return "anshil"
        }
    }
    
    var name: String {
        switch self {
        case .aryan: return "Aryan Mittal"
        case .aryav: return "Aryav Nagar"
        case .anshil: return "Anshil Patel"
        }
    }
    
    var role: String {
        switch self {
        case .aryan: return "App Development and Design"
        case .aryav: return "Data Science and Machine Learning"
        case .anshil: return "Colors and Marketing"
        }
    }
    
    var desc: String {
        switch self {
        case .aryan: return "In addition to building apps for his community, Aryan enjoys writing for his blog and biking with his friends."
        case .aryav: return "Aryav is an aspiring data scientist. He also has a strong passion for photography and loves to learn about upcoming cars."
        case .anshil: return "Anshil chose colors for each stock. He also likes cars."
        }
    }
    
    var iconName: String {
        switch self {
        case .aryan: return "apps.iphone"
        case .aryav: return "gearshape.2"
        case .anshil: return "megaphone"
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView().preferredColorScheme(.dark)
    }
}
