//
//  DestinationFactory.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 25/01/2026.
//

import SwiftUI

extension AppRouter.Route {
    @ViewBuilder
    internal func destinationView(in tab: AppRouter.Tab, appRouter: AppRouter) -> some View {
        switch tab {
        case .main:
            MainTabDestinationFactory.view(for: self, appRouter: appRouter)
        }
    }
}
