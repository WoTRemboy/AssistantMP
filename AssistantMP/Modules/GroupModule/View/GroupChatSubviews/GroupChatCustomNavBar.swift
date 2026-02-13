//
//  GroupChatCustomNavBar.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 13/02/2026.
//

import SwiftUI

struct GroupChatCustomNavBar: View {
    
    @EnvironmentObject private var appRouter: AppRouter
    
    private let member: GroupMember
    
    init(member: GroupMember) {
        self.member = member
    }
    
    internal var body: some View {
        NavigationBar(
            isDisabled: false,
            start: 0,
            offset: -100,
            topPadding: 0
        ) {
            Button {
                appRouter.pop(in: .main)
            } label: {
                Image.Chevron.backward
            }
            .buttonStyle(.plain)
        } center: {
            memberContent
        } trailing: {
            Button {
                
            } label: {
                Image.General.trash
            }
            .buttonStyle(.plain)
        }
    }
    
    private var memberContent: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(member.name)
                .font(.system(size: 20, weight: .bold))
                .lineLimit(1)
            
            HStack(spacing: 6) {
                Circle()
                    .fill(member.status.color)
                    .frame(width: 6, height: 6)
                
                Text(member.status.title)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(Color.Label.secondary)
            }
        }
    }
}

#Preview {
    GroupChatCustomNavBar(member: .sample)
        .environmentObject(AppRouter())
}
