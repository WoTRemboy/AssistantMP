//
//  DashboardGroupModel.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 21/01/2026.
//

import SwiftUI

enum DashboardGroup: CaseIterable {
    case jobs
    case games
    case groups
    
    internal var title: String {
        switch self {
        case .jobs: return Texts.Dashboard.Sections.jobs
        case .games: return Texts.Dashboard.Sections.games
        case .groups: return Texts.Dashboard.Sections.friends
        }
    }
    
    internal var image: Image {
        switch self {
        case .jobs: return Image.Dashboard.Sections.jobs
        case .games: return Image.Dashboard.Sections.games
        case .groups: return Image.Dashboard.Sections.friends
        }
    }
    
    internal var offset: (x: CGFloat, y: CGFloat) {
        switch self {
        case .jobs: return (0, 18)
        case .games: return (18, 30)
        case .groups: return (5, 18)
        }
    }
    
    internal func performAction(appRouter: AppRouter) {
        switch self {
        case .jobs:
            break
        case .games:
            break
        case .groups:
            appRouter.push(.group, in: .main)
        }
    }
}
