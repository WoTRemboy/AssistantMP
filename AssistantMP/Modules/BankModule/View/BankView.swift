//
//  BankView.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 02/02/2026.
//

import SwiftUI

struct BankView: View {
    
    @EnvironmentObject private var appRouter: AppRouter
    @State private var offset: CGFloat = 0
    
    internal var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 16) {
                title
                managementView
                operationsView
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
            propertyNavBar
        }
        .enableFillSwipePop(true)
    }
    
    private var title: some View {
        Text(Texts.Bank.title)
            .font(.system(size: 25, weight: .bold))
            .frame(maxWidth: .infinity, alignment: .leading)
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
    
    private var managementView: some View {
        BankManagementView()
    }
    
    private var operationsView: some View {
        BankTransactionsView()
    }
    
    private var propertyNavBar: some View {
        BankCustomNavBar(title: Texts.Bank.titleShort, offset: offset)
    }
}

#Preview {
    BankView()
        .environmentObject(AppRouter())
}
