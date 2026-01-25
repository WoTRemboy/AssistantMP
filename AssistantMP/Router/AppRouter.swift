//
//  AppRouter.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 25/01/2026.
//

import SwiftUI
import Combine

final class AppRouter: ObservableObject {
    
    @Published internal var selectedTab: Tab = .main
    @Published internal var navigationPaths: [Tab: [Route]] = Tab.allCases.reduce(into: [:]) { $0[$1] = [] }
    
    enum Tab: CaseIterable, Hashable {
        case main
    }
    
    enum Route: Hashable {
        case dashboard
        case profile
    }
    
    internal func push(_ route: Route, in tab: Tab) {
        navigationPaths[tab, default: []].append(route)
    }
    
    internal func pop(in tab: Tab) {
        _ = navigationPaths[tab]?.popLast()
    }
    
    internal func popToRoot(in tab: Tab) {
        navigationPaths[tab] = []
    }
    
    internal func setTab(to tab: Tab) {
        if selectedTab == tab {
            popToRoot(in: tab)
        } else {
            selectedTab = tab
        }
    }
}
