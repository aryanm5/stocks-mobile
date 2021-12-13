//
//  OnboardingView.swift
//  stocks
//
//  Created by Aryan Mittal on 12/13/21.
//

import SwiftUI

struct OnboardingView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            Text("Welcome to Stockscast")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
            
            HStack {
                Spacer()
                List {
                    ForEach(OnboardingItem.allCases) { item in
                        OnboardingRow(item: item)
                    }
                }
                .disabled(true)
                Spacer()
            }
            
            Button(action: close) {
                Text("Continue")
                    .foregroundColor(Color.white)
                    .fontWeight(.medium)
                    .padding(.vertical, 15)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(Color.accentColor)
                    .clipShape(RoundedRectangle(cornerRadius: 15.0, style: .continuous))
            }
            .padding(.bottom, 50)
            .padding(.horizontal, 15)
        }
        .padding(.top, 70)
        .padding(.horizontal, 5)
        .background(Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all))
    }
    
    private func close() {
        isPresented = false
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(isPresented: .constant(true))
    }
}
