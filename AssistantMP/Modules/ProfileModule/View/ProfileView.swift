//
//  ProfileView.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 23/01/2026.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var offset: CGFloat = 0
    private let user: User = .sample
    
    internal var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 16) {
                infoView
                AccountBankView(user: user)
                AccountPropertyView()
            }
            .padding(.horizontal)
            .navigationBarHidden(true)
        }
        .coordinateSpace(name: "scroll")
        .onPreferenceChange(HeaderBottomPreferenceKey.self) { minY in
            withAnimation(.easeInOut(duration: 0.2)) {
                offset = minY
            }
        }
        .safeAreaInset(edge: .top) {
            ProfileCustomNavBar(username: user.name, offset: offset)
        }
        .enableFillSwipePop(true)
    }
    
    private var infoView: some View {
        AccountInfoView(user: user)
            .background(
                GeometryReader { proxy in
                    Color.clear
                        .preference(
                            key: HeaderBottomPreferenceKey.self,
                            value: proxy.frame(in: .named("scroll")).minY
                        )
                }
            )
    }
}

private struct HeaderBottomPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = min(value, nextValue())
    }
}

#Preview {
    ProfileView()
        .environmentObject(AppRouter())
}
