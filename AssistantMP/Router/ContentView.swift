//
//  ContentView.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 25/01/2026.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var appRouter = AppRouter()
    
    private func bindingForTab(_ tab: AppRouter.Tab) -> Binding<[AppRouter.Route]> {
        Binding(
            get: { appRouter.navigationPaths[tab] ?? [] },
            set: { appRouter.navigationPaths[tab] = $0 }
        )
    }
    
    internal var body: some View {
        NavigationStack(path: bindingForTab(.main)) {
            TabItems.mainTab(appRouter: appRouter)
                .navigationBarHidden(true)
        }
        
    }
}

#Preview {
    ContentView()
}
