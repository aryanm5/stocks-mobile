//
//  SettingsItem.swift
//  stocks
//
//  Created by Aryan Mittal on 12/5/21.
//

import SwiftUI

enum SettingsItem {
    
    case rate, share, feedback, about
    
    var title: String {
        switch self {
        case .rate: return "Rate the App"
        case .share: return "Share"
        case .feedback: return "Feedback"
        case .about: return "About the App"
        }
    }
    
    var subtitle: String {
        switch self {
        case .rate: return "Are you loving it?"
        case .share: return "Tell your friends!"
        case .feedback: return "aryan@mittaldev.com"
        case .about: return "Learn how it works!"
        }
    }
    
    var iconName: String {
        switch self {
        case .rate: return "star.fill"
        case .share: return "square.and.arrow.up"
        case .feedback: return "at"
        case .about: return "hammer.fill"
        }
    }
    
    var color: Color {
        switch self {
        case .rate: return .pink
        case .share: return .green
        case .feedback: return .blue
        case .about: return .orange
        }
    }
}
