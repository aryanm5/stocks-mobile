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
        Text("This is the onboarding.")
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
