//
//  ProfileCustomNavBar.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 25/01/2026.
//

import SwiftUI

struct ProfileCustomNavBar: View {
    
    @EnvironmentObject private var appRouter: AppRouter
    
    private let username: String
    private let start: CGFloat = 50
    private let offset: CGFloat

    init(username: String?, offset: CGFloat) {
        self.username = username ?? "Username"
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
            Text(username)
                .font(.system(size: 20, weight: .bold))
                .lineLimit(1)
        } trailing: {
            HStack(spacing: 16) {
                ForEach(NavbarAction.allCases, id: \.self) { type in
                    IconCircleButton(type: type)
                }
            }
        }
    }
}

#Preview {
    ProfileCustomNavBar(username: "Username", offset: 0)
        .environmentObject(AppRouter())
}
