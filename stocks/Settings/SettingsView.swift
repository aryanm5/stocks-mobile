//
//  SettingsView.swift
//  stocks
//
//  Created by Aryan Mittal on 12/5/21.
//

import SwiftUI

struct SettingsView: View {
    let rateURL: URL = URL(string: "itms-apps://apps.apple.com/app/id1590957645?action=write-review")!
    let shareURL: URL = URL(string: "https://apps.apple.com/app/id1590957645")!
    let feedbackURL: URL = URL(string: "mailto:aryan@mittaldev.com")!
    
    var body: some View {
        List {
            Section {
                NavigationLink(destination: CustomizationView()) {
                    SettingsRow(item: .custom)
                }
            }
            
            Section(footer: footer) {
                Button(action: { openURL(rateURL) }) {
                    SettingsRow(item: .rate)
                }
                Button(action: {
                    present(UIActivityViewController(activityItems: [shareURL], applicationActivities: nil), animated: true)
                }) {
                    SettingsRow(item: .share)
                }
                Button(action: { openURL(feedbackURL) }) {
                    SettingsRow(item: .feedback)
                }
                NavigationLink(destination: AboutView()) {
                    SettingsRow(item: .about)
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Settings")
    }
    
    var footer: some View {
        StocksApp.fullVersion
            .map { Text("VERSION \($0)") }
            .textCase(.uppercase)
            .foregroundColor(.secondary)
            .font(.caption2)
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity, alignment: .center)
            .listRowInsets(EdgeInsets(top: 24.0, leading: 0.0, bottom: 24.0, trailing: 0.0))
    }
    
    private func openURL(_ url: URL) {
        UIApplication.shared.open(url)
    }
    
    private func present(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        guard var topController = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController else { return }
        
        while let presentedViewController = topController.presentedViewController {
            topController = presentedViewController
        }
        
        topController.present(viewController, animated: animated, completion: completion)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
