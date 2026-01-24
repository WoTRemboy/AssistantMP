//
//  PropertyModel.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 23/01/2026.
//

import Foundation
import SwiftUI

struct PropertyItem: Identifiable, Hashable {
    let id: UUID
    var title: String
    var paymentDate: Date?
    var accentColor: Color

    init(id: UUID = UUID(), title: String, paymentDate: Date?, accentColor: Color) {
        self.id = id
        self.title = title
        self.paymentDate = paymentDate
        self.accentColor = accentColor
    }
}

enum PropertyCategory: String, CaseIterable, Identifiable {
    case home = "home"
    case business = "business"
    case transport = "transport"

    var id: String { rawValue }
    
    internal var title: String {
        switch self {
        case .home:
            Texts.Profile.Property.home
        case .business:
            Texts.Profile.Property.business
        case .transport:
            Texts.Profile.Property.transport
        }
    }
}

extension PropertyItem {
    static internal var sample: PropertyItem {
        PropertyItem(title: "Северо-западная, 78", paymentDate: Date.makeDate(2026, 1, 30), accentColor: .gray)
    }
    
    
    static internal var sampleSections: [PropertyCategory: [PropertyItem]] {
        [
            .home: [
                PropertyItem(title: "Центральная, 42", paymentDate: Date.makeDate(2026, 1, 27), accentColor: .pink),
                PropertyItem(title: "Юго-восточная, 55", paymentDate: Date.makeDate(2026, 2, 25), accentColor: .gray),
                PropertyItem(title: "Северо-западная, 78", paymentDate: Date.makeDate(2026, 1, 30), accentColor: .gray)
            ],
            .business: [
                PropertyItem(title: "Central Los Santos Автосалон", paymentDate: Date.makeDate(2026, 2, 12), accentColor: .gray),
                PropertyItem(title: "Магазин продуктов 24/7", paymentDate: Date.makeDate(2026, 2, 20), accentColor: .gray)
            ],
            .transport: [
                PropertyItem(title: "Elegy RH8", paymentDate: nil, accentColor: .gray),
                PropertyItem(title: "Sultan RS", paymentDate: nil, accentColor: .gray)
            ]
        ]
    }
}

enum PropertyWarningStyle {
    case warning, info
    
    internal var background: Color {
        switch self {
        case .warning: return Color.red.opacity(0.12)
        case .info: return Color.black.opacity(0.08)
        }
    }

    internal var foreground: Color {
        switch self {
        case .warning: return .red
        case .info: return .primary
        }
    }
}
