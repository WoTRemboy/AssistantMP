//
//  GroupCustomNavBar.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 05/02/2026.
//

import SwiftUI

struct GroupCustomNavBar: View {
    
    @EnvironmentObject private var appRouter: AppRouter
    
    private let title: String
    private let start: CGFloat = 30
    private let offset: CGFloat

    init(title: String, offset: CGFloat) {
        self.title = title
        self.offset = offset
    }

    internal var body: some View {
        NavigationBar(
            isDisabled: false,
            start: start,
            offset: offset,
            topPadding: 0
        ) {
            Button {
                appRouter.pop(in: .main)
            } label: {
                Image.Chevron.backward
            }
            .buttonStyle(.plain)
        } center: {
            Text(title)
                .font(.system(size: 20, weight: .bold))
                .lineLimit(1)
        } trailing: {
            HStack(spacing: 16) {
                ForEach(NavbarAction.giftBankCases, id: \.self) { type in
                    IconCircleButton(type: type)
                }
            }
        }
    }
}

#Preview {
    GroupCustomNavBar(title: Texts.Group.title, offset: 0)
        .environmentObject(AppRouter())
}


