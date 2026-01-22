//
//  SplashScreenView.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 22/01/2026.
//

import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.BackColors.backDefault)
            
            Image.Opening.logo
        }
        .ignoresSafeArea()
    }
}

struct CustomSplashTransition: Transition {
    private var isRoot: Bool
    
    init(isRoot: Bool) {
        self.isRoot = isRoot
    }
    
    internal func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .offset(y: phase.isIdentity ? 0 : isRoot ? screenSize.height : -screenSize.height)
    }
    
    private var screenSize: CGSize {
        if let screenSize = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.screen.bounds.size {
            return screenSize
        }
        return .zero
    }
}

#Preview {
    SplashScreenView()
}
