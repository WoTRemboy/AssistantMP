//
//  ProfileCustomNavBar.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 25/01/2026.
//

import SwiftUI

struct ProfileCustomNavBar: View {
    
    @EnvironmentObject private var appRouter: AppRouter
    
//    private let username: String
//    
//    init(username: String?) {
//        self.username = username ?? "Username"
//    }

    internal var body: some View {
        HStack(spacing: 0) {
            Button {
                appRouter.pop(in: .main)
            } label: {
                Image.Chevron.backward
            }
            .buttonStyle(.plain)

            Spacer()

            HStack(spacing: 16) {
                ForEach(NavbarAction.allCases, id: \.self) { type in
                    IconCircleButton(type: type)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(Color.BackColors.backDefault)
    }
    
    private var profileIcon: some View {
        Circle()
            .fill(Color.gray.opacity(0.2))
            .frame(width: 34, height: 34)
            .overlay(
                Image(systemName: "person.fill")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.gray)
            )
    }
}

#Preview {
    ProfileCustomNavBar()
        .environmentObject(AppRouter())
}
