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
    @State private var updateIcon: Bool = true
    
    let icons: [CustomIcon] = [.original, .light, .dark, .mono, .gold]
    
    let rateURL: URL = URL(string: "itms-apps://apps.apple.com/app/id1599169546?action=write-review")!
    let shareURL: URL = URL(string: "https://apps.apple.com/app/id1599169546")!
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
                VStack(alignment: .leading) {
                    Text("App Icon")
                    Picker(selection: $currentIcon, label: EmptyView()) {
                        ForEach(icons, id: \.name) { icon in
                            IconRow(icon: icon, currentIcon: $currentIcon)
                                .tag(icon.name)
                        }
                    }
                    .labelsHidden()
                    .onChange(of: currentIcon) { value in
                        if updateIcon {
                            UIApplication.shared.setAlternateIconName(value)
                        } else {
                            updateIcon = true
                        }
                    }
                    .onChange(of: updateIcon) { value in
                        if !value {
                            if currentIcon == UIApplication.shared.alternateIconName {
                                updateIcon = true
                            } else {
                                currentIcon = UIApplication.shared.alternateIconName
                            }
                        }
                    }
                }
            }
            
            Section(footer: footer) {
                Button(action: { openURL(rateURL) }) {
                    SettingsRow(item: .rate)
                }
                Button(action: {
                    share()
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
        .listStyle(.insetGrouped)
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            updateIcon = false
        }
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
    
    private func openURL(_ url: URL) -> Void {
        UIApplication.shared.open(url)
    }
    
    private func share() -> Void {
        let shareActivity: UIActivityViewController = UIActivityViewController(activityItems: [shareURL], applicationActivities: nil)
        
        if let vc: UIViewController = UIApplication.shared.windows.first?.rootViewController {
            shareActivity.popoverPresentationController?.sourceView = vc.view
            //Setup share activity position on screen on bottom center
            shareActivity.popoverPresentationController?.sourceRect = CGRect(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height, width: 0, height: 0)
            shareActivity.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.down
            vc.present(shareActivity, animated: true, completion: nil)
        }
    }
}

struct IconRow: View {
    let icon: CustomIcon
    
    @Binding var currentIcon: String?
    
    var body: some View {
        HStack(spacing: 20) {
            Image(icon.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50)
                .cornerRadius(10)
            Text(icon.display)
                .foregroundColor(.primary)
        }
        .contentShape(Rectangle())
        .frame(maxWidth: .infinity, alignment: .leading)
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
