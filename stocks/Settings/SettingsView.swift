//
//  SettingsView.swift
//  stocks
//
//  Created by Aryan Mittal on 12/5/21.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("laserMode") var laserMode: Bool = false
    
    @State private var currentIcon: String? = UIApplication.shared.alternateIconName
    
    let rateURL: URL = URL(string: "itms-apps://apps.apple.com/app/id1590957645?action=write-review")!
    let shareURL: URL = URL(string: "https://apps.apple.com/app/id1590957645")!
    let feedbackURL: URL = URL(string: "mailto:aryan@mittaldev.com")!
    
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
                Text("App Icon")
                IconRow(iconName: nil, imageName: "AppImage", display: "Original", currentIcon: $currentIcon)
                IconRow(iconName: "DarkIcon", imageName: "DarkImage", display: "Simple Light", currentIcon: $currentIcon)
                IconRow(iconName: "DarkIcon", imageName: "DarkImage", display: "Simple Dark", currentIcon: $currentIcon)
                IconRow(iconName: "DarkIcon", imageName: "DarkImage", display: "Gold Deluxe", currentIcon: $currentIcon)
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
        .listStyle(.insetGrouped) //InsetGroupedListStyle()
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
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

struct IconRow: View {
    let iconName: String?
    let imageName: String
    let display: String
    
    @Binding var currentIcon: String?
    
    var body: some View {
        Button(action: {
            UIApplication.shared.setAlternateIconName(iconName) { error in
                if error == nil {
                    currentIcon = iconName
                }
            }
        }) {
            HStack(spacing: 20) {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50)
                    .cornerRadius(10)
                Text(display)
                Spacer()
                if currentIcon == iconName {
                    Image(systemName: "checkmark")
                        .foregroundColor(.blue)
                }
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
