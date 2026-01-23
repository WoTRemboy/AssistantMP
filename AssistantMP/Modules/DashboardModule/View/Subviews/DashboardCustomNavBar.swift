//
//  DashboardCustomNavBar.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 22/01/2026.
//

import SwiftUI

struct DashboardCustomNavBar: View {
    private let username: String
    
    init(username: String?) {
        self.username = username ?? "Username"
    }

    internal var body: some View {
        HStack(spacing: 0) {
            Button {
                
            } label: {
                HStack(spacing: 8) {
                    profileIcon
                    profileView
                }
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
    
    private var profileView: some View {
        HStack(spacing: 8) {
            Text(username)
                .font(.system(size: 25, weight: .bold))
                .foregroundStyle(.primary)
                .lineLimit(1)
                .minimumScaleFactor(0.5)

            Image.Chevron.forward
        }
    }
}

struct IconCircleButton: View {
    private let type: NavbarAction
    
    init(type: NavbarAction) {
        self.type = type
    }

    internal var body: some View {
        Button {
            
        } label: {
            type.icon
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ZStack {
        Color(.systemBackground)
            .ignoresSafeArea()
        VStack {
            DashboardCustomNavBar(username: nil)
            Spacer()
        }
    }
}
