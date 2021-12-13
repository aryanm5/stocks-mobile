//
//  OnboardingRow.swift
//  stocks
//
//  Created by Aryan Mittal on 12/13/21.
//

import SwiftUI

struct OnboardingRow: View {
    
    let item: OnboardingItem
    
    var body: some View {
        HStack(alignment: .center, spacing: 0.0) {
            Image(systemName: item.systemImageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 26, height: 26)
                .padding(13.0)
                .background(item.color)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 12.0, style: .continuous))
            
            VStack(alignment: .leading, spacing: 3.0) {
                Text(item.title)
                    .font(.system(size: 16))
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                    .lineLimit(1)
                    .multilineTextAlignment(.leading)
                
                Text(item.subtitle)
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
            }
            .padding(.leading, 20)
        }
        .padding(.vertical, 22)
        .listRowBackground(Color(.systemGroupedBackground))
        .listRowSeparator(.hidden)
    }
}


struct OnboardingRow_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingRow(item: .future)
    }
}
