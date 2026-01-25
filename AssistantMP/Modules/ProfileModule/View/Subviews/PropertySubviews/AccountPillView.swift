//
//  AccountPillView.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 24/01/2026.
//

import SwiftUI

struct AccountPillView: View {
    private let text: String
    private let style: PropertyWarningStyle
    
    init(text: String, style: PropertyWarningStyle) {
        self.text = text
        self.style = style
    }
    
    internal var body: some View {
        HStack(spacing: 3) {
            Image.Profile.clock
                .renderingMode(.template)
            
            Text(text)
                .font(.system(size: 12, weight: .bold))
        }
        .foregroundStyle(style.foreground)
        .padding(.horizontal, 10)
        .frame(maxHeight: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(style.background)
        )
    }
}

#Preview {
    AccountPillView(text: "4 days", style: .info)
        .frame(height: 30)
}
