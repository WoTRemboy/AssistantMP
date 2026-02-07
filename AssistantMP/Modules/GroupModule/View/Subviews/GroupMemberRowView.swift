//
//  GroupMemberRowView.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 07/02/2026.
//

import SwiftUI

struct GroupMemberRowView: View {
    let member: GroupMember

    var body: some View {
        HStack(spacing: 2) {
            HStack(spacing: 6) {
                avatar
                memberInfo
                Spacer()
                messagesCountImage
            }
            .padding(16)
            .background(
                Color(.systemGray5)
            )
            deleteButton
        }
        .clipShape(.rect(cornerRadius: 16))
    }

    private var avatar: some View {
        ZStack(alignment: .topTrailing) {
            Image.Group.personPlaceholder

            if member.isOnline != .offline {
                Circle()
                    .fill(member.isOnline.color)
                    .frame(width: 8, height: 8)
                    .overlay(
                        Circle()
                            .stroke(Color(.systemGray5), lineWidth: 1)
                    )
                    .offset(x: -2, y: 6)
            }
        }
    }

    private var memberInfo: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(member.name)
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(Color.Label.primary)

            Text("\(Texts.Group.id): \(member.staticId)")
                .font(.system(size: 16, weight: .regular))
                .foregroundStyle(Color.Label.secondary)
        }
    }

    private var deleteButton: some View {
        Button {
            
        } label: {
            Image.General.trash
                .frame(maxHeight: .infinity)
                .padding(.horizontal, 16)
                .background {
                    Color(.systemGray5)
                }
        }
        .buttonStyle(.plain)
    }
    
    private var messagesCountImage: some View {
        ZStack {
            if member.unreadCount > 0 {
                Image.Group.messages
                    .overlay {
                        Text("\(member.unreadCount)")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundStyle(Color.white)
                            .padding(4)
                            .offset(y: -1)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                    }
            }
        }
    }
}

#Preview {
    GroupMemberRowView(member: .init(name: "Test_User", staticId: "123", isOnline: .online, unreadCount: 5))
        .frame(height: 74)
}
