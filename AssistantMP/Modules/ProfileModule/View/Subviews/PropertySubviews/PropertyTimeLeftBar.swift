//
//  PropertyTimeLeftBar.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 24/01/2026.
//

import SwiftUI

struct PropertyTimeLeftBar: View {
    
    @State private var displayedFraction: CGFloat = 1.0
    
    private let fraction: CGFloat
    private let height: CGFloat
    private let style: PropertyWarningStyle
    
    init(fraction: CGFloat, height: CGFloat = 6, style: PropertyWarningStyle) {
        self.fraction = fraction
        self.height = height
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
        .frame(height: height)
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
    PropertyTimeLeftBar(fraction: 15, style: .info)
}
