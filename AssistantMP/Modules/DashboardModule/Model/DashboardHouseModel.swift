//
//  DashboardHouseModel.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 21/01/2026.
//

import SwiftUI

enum DashboardHouse {
    case locked
    case unlocked
    
    internal var title: String {
        switch self {
        case .locked:
            "Закрыт"
        case .unlocked:
            "Открыт"
        }
    }
    
    internal var actionTitle: String {
        switch self {
        case .locked:
            "Открыть дом"
        case .unlocked:
            "Закрыть дом"
        }
    }
    
    internal var icon: Image {
        switch self {
        case .locked:
            Image.Dashboard.House.locked
        case .unlocked:
            Image.Dashboard.House.unlocked
        }
    }
    
    internal var color: Color {
        switch self {
        case .locked: .green
        case .unlocked: .red
        }
    }
}
