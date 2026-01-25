//
//  TabItems.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 25/01/2026.
//

import SwiftUI

/// A utility struct providing configured tab items for the main tab bar.
struct TabItems {
    
    static func mainTab(appRouter: AppRouter) -> some View {
        DashboardView()
            .environmentObject(appRouter)
            .navigationDestination(for: AppRouter.Route.self) { route in
                route.destinationView(in: .main, appRouter: appRouter)
            }
    }
}

