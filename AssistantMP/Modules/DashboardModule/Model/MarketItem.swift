//
//  MarketItem.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 22/01/2026.
//

import SwiftUI

struct MarketItem: Identifiable {
    let id = UUID()
    let title: String
    let quantity: Int
    let price: Int
    let status: Status
    
    enum Status: Equatable {
        case active(endDate: Date)
        case expiring(endDate: Date)
        case sold

        var title: String {
            switch self {
            case .active: return Texts.Dashboard.Market.active
            case .expiring: return Texts.Dashboard.Market.expired
            case .sold: return Texts.Dashboard.Market.sold
            }
        }

        var indicator: Image {
            switch self {
            case .active: Image.Dashboard.Market.active
            case .expiring: Image.Dashboard.Market.expiring
            case .sold: Image.Dashboard.Market.sold
            }
        }
    }
    
    static var sample: [MarketItem] {
        return [
            .init(title: "Автомобиль Elegy", quantity: 1, price: 9_999_999, status: .active(endDate: Date().addingTimeInterval(5 * 3600 + 5 * 60 + 10))),
            .init(title: "Автомобиль Elegy", quantity: 100, price: 1_999, status: .expiring(endDate: Date().addingTimeInterval(5 * 60 + 10))),
            .init(title: "Патроны", quantity: 10, price: 25, status: .sold)
        ]
    }
}
