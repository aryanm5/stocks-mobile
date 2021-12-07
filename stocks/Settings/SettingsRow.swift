//
//  SettingsRow.swift
//  stocks
//
//  Created by Aryan Mittal on 12/5/21.
//

import SwiftUI

struct SettingsRow: View {
    let item: SettingsItem
    
    var body: some View {
        HStack(alignment: .center, spacing: 16.0) {
            Image(systemName: item.iconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 17.0, height: 17.0)
                .padding(6.0)
                .background(item.color)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 6.0, style: .continuous))
            
            VStack(alignment: .leading, spacing: 3.0) {
                Text(item.title)
                    .font(.body)
                    .foregroundColor(.primary)
                    .lineLimit(1)
                
                Text(item.subtitle)
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
        }
        .padding(.vertical, 5.0)
    }
}

struct SettingsRow_Previews: PreviewProvider {
    static var previews: some View {
        SettingsRow(item: .rate)
    }
}
