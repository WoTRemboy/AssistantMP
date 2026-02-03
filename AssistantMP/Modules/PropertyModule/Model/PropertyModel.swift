//
//  PropertyModel.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 23/01/2026.
//

import Foundation
import SwiftUI

struct PropertyItem: Identifiable, Hashable, Equatable {
    let id: UUID
    var title: String
    var address: String?
    var paymentDate: Date?
    var lockStatus: PropertyLock?
    var paymentAmount: Int?
    var accentColor: Color

    init(id: UUID = UUID(),
         title: String,
         address: String? = nil,
         paymentDate: Date?,
         lockStatus: PropertyLock? = nil,
         paymentAmount: Int? = nil,
         accentColor: Color) {
        self.id = id
        self.title = title
        self.address = address
        self.paymentDate = paymentDate
        self.lockStatus = lockStatus
        self.paymentAmount = paymentAmount
        self.accentColor = accentColor
    }
    
    static func == (lhs: PropertyItem, rhs: PropertyItem) -> Bool {
        lhs.id == rhs.id
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
    
    internal var noun: String {
        switch self {
        case .home: return Texts.Property.Noun.house
        case .business: return Texts.Property.Noun.business
        case .transport: return Texts.Property.Noun.transport
        }
    }
}

extension PropertyItem {
    static internal var sample: PropertyItem {
        PropertyItem(title: "Центральная, 42", address: "Центральная, 42", paymentDate: Date.makeDate(2026, 2, 6), lockStatus: .locked, paymentAmount: 500_000, accentColor: .pink)
    }
    
    static internal var sampleList: [PropertyItem] {
        [
            PropertyItem(title: "Центральная, 42", address: "Центральная, 42", paymentDate: Date.makeDate(2026, 2, 6), lockStatus: .locked, paymentAmount: 500_000, accentColor: .pink),
            PropertyItem(title: "Юго-восточная, 55", address: "Юго-восточная, 55", paymentDate: Date.makeDate(2026, 2, 25), lockStatus: .unlocked, paymentAmount: 750_000, accentColor: .gray),
            PropertyItem(title: "Северо-западная, 78", address: "Северо-западная, 78", paymentDate: Date.makeDate(2026, 2, 10), lockStatus: .unlocked, paymentAmount: 430_000, accentColor: .gray)
        ]
    }
    
    
    static internal var sampleSections: [PropertyCategory: [PropertyItem]] {
        [
            .home: [
                PropertyItem(title: "Центральная, 42", address: "Центральная, 42", paymentDate: Date.makeDate(2026, 2, 6), lockStatus: .locked, paymentAmount: 500_000, accentColor: .pink),
                PropertyItem(title: "Юго-восточная, 55", address: "Юго-восточная, 55", paymentDate: Date.makeDate(2026, 2, 25), lockStatus: .unlocked, paymentAmount: 750_000, accentColor: .gray),
                PropertyItem(title: "Северо-западная, 78", address: "Северо-западная, 78", paymentDate: Date.makeDate(2026, 2, 10), lockStatus: .unlocked, paymentAmount: 430_000, accentColor: .gray)
            ],
            .business: [
                PropertyItem(title: "Central Los Santos Автосалон", address: "Центральная, 445", paymentDate: Date.makeDate(2026, 2, 12), paymentAmount: 1_250_750, accentColor: .gray),
                PropertyItem(title: "Магазин продуктов 24/7",  address: "Северо-западная, 785", paymentDate: Date.makeDate(2026, 2, 20), paymentAmount: 1_500_000, accentColor: .gray)
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
