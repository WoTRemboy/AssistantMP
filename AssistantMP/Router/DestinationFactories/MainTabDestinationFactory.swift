//
//  MainTabDestinationFactory.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 25/01/2026.
//

import SwiftUI

struct MainTabDestinationFactory {
    @ViewBuilder
    static func view(for route: AppRouter.Route, appRouter: AppRouter) -> some View {
        switch route {
        case .dashboard:
            DashboardView()
            
        case .profile:
            ProfileView()
                .environmentObject(appRouter)
        }
    }
}
