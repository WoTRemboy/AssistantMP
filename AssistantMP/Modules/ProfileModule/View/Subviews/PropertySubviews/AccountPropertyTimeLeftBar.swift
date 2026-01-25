//
//  AccountPropertyTimeLeftBar.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 24/01/2026.
//

import SwiftUI

struct AccountPropertyTimeLeftBar: View {
    
    @State private var displayedFraction: CGFloat = 1.0
    
    private let fraction: CGFloat
    private let style: PropertyWarningStyle
    
    init(fraction: CGFloat, style: PropertyWarningStyle) {
        self.fraction = fraction
        self.style = style
    }

    internal var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Capsule(style: .continuous)
                    .fill(Color.black.opacity(0.08))
                Capsule(style: .continuous)
                    .fill(style.foreground)
                    .frame(width: max(4, geo.size.width * displayedFraction))
            }
        }
        .frame(height: 6)
        .onAppear {
            displayedFraction = 1.0
            DispatchQueue.main.async {
                withAnimation(.easeOut(duration: 0.8)) {
                    displayedFraction = min(1, max(0, fraction))
                }
            }
        }
        .onChange(of: fraction) { _, newValue in
            withAnimation(.easeInOut(duration: 0.25)) {
                displayedFraction = min(1, max(0, newValue))
            }
        }
    }
}

#Preview {
    AccountPropertyTimeLeftBar(fraction: 15, style: .info)
}
