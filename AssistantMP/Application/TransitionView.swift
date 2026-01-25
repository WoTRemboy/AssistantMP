//
//  TransitionView.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 25/01/2026.
//

import SwiftUI

struct TransitionView: View {
    
    @State private var showsSplashScreen: Bool = true
    
    internal var body: some View {
        ZStack {
            if showsSplashScreen {
                SplashScreenView()
                    .transition(CustomSplashTransition(isRoot: false))
            } else {
                ContentView()
                    .transition(CustomSplashTransition(isRoot: true))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.BackColors.backDefault)
        .task {
            guard showsSplashScreen else { return }
            try? await Task.sleep(for: .seconds(0.5))
            withAnimation(.smooth(duration: 0.45)) {
                showsSplashScreen = false
            }
        }
    }
    
    private var safeArea: UIEdgeInsets {
        if let safeArea = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.keyWindow?.safeAreaInsets {
            return safeArea
        }
        return .zero
    }
}

#Preview {
    TransitionView()
}
