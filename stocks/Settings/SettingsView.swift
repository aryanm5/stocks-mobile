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
    
    let icons: [CustomIcon] = [.original, .light, .dark, .mono, .gold]
    
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
            Section(header: Text("App Icon")) {
                ForEach(icons, id: \.image) { icon in
                    IconRow(icon: icon, currentIcon: $currentIcon)
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
    let icon: CustomIcon
    
    @Binding var currentIcon: String?
    
    var body: some View {
        Button(action: {
            UIApplication.shared.setAlternateIconName(icon.name) { error in
                if error == nil {
                    currentIcon = icon.name
                }
            }
        }) {
            HStack(spacing: 20) {
                Image(icon.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50)
                    .cornerRadius(10)
                Text(icon.display)
                Spacer()
                if currentIcon == icon.name {
                    Image(systemName: "checkmark")
                        .foregroundColor(.blue)
                }
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

enum CustomIcon: Int {
    case original, light, dark, mono, gold
    
    var name: String? {
        switch self {
        case .original: return nil
        case .light: return "LightIcon"
        case .dark: return "DarkIcon"
        case .mono: return "MonoIcon"
        case .gold: return "GoldIcon"
        }
    }
    
    var image: String {
        switch self {
        case .original: return "AppImage"
        case .light: return "LightImage"
        case .dark: return "DarkImage"
        case .mono: return "MonoImage"
        case .gold: return "GoldImage"
        }
    }
    
    var display: String {
        switch self {
        case .original: return "Original"
        case .light: return "Simple Light"
        case .dark: return "Simple Dark"
        case .mono: return "Mono"
        case .gold: return "Gold Deluxe"
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
