//
//  DashboardMarketModel.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 22/01/2026.
//

enum MarketSegment: String, CaseIterable {
     case general = "general"
     case sale = "sale"
    
    internal var title: String {
        switch self {
        case .general:
            Texts.Dashboard.Market.general
        case .sale:
            Texts.Dashboard.Market.sale
        }
    }
}
