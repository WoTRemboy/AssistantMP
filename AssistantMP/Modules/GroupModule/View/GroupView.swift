//
//  GroupView.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 05/02/2026.
//

import SwiftUI

struct GroupView: View {
    
    @StateObject private var viewModel = GroupViewModel()
    @State private var offset: CGFloat = 0
    
    internal var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 12) {
                titleLabel
                GroupTabsView(selected: $viewModel.selectedCategory)
                GroupAddMemberView(
                    text: $viewModel.addMemberId,
                    action: viewModel.addMember
                )
                GroupMembersCountView(text: viewModel.membersCountText)
                GroupMembersListView(members: viewModel.visibleMembers)
                GroupMessageAllButton(title: Texts.Group.messageAll)
            }
            .padding(.horizontal)
            .padding(.bottom, 16)
            .navigationBarHidden(true)
        }
        .coordinateSpace(name: "scroll")
        .onPreferenceChange(HeaderBottomPreferenceKey.self) { minY in
            withAnimation(.easeInOut(duration: 0.2)) {
                offset = minY
            }
        }
        .safeAreaInset(edge: .top) {
            GroupCustomNavBar(title: Texts.Group.title, offset: offset)
        }
        .enableFillSwipePop(true)
    }
    
    private var titleLabel: some View {
        Text(Texts.Group.title)
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
}

private struct GroupTabsView: View {
    @Binding var selected: GroupCategory

    var body: some View {
        HStack(spacing: 8) {
            ForEach(Array(GroupCategory.allCases), id: \.self) { category in
                let isSelected = selected == category
                Button {
                    selected = category
                } label: {
                    HStack(spacing: 6) {
                        Text(category.title)
                            .font(.system(size: 14, weight: .bold))
                            .foregroundStyle(isSelected ? Color.Label.white : Color.Label.primary)

                        if category.showsNotification {
                            Circle()
                                .fill(Color.red)
                                .frame(width: 6, height: 6)
                        }
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(isSelected ? Color.black : Color(.systemGray4))
                    )
                }
                .buttonStyle(.plain)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 6)
    }
}

private struct GroupAddMemberView: View {
    @Binding var text: String
    var action: () -> Void

    var body: some View {
        HStack(spacing: 8) {
            TextField(Texts.Group.addPlaceholder, text: $text)
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(Color.Label.primary)
                .keyboardType(.numberPad)
                .padding(.vertical, 10)
                .padding(.horizontal, 12)
                .background(
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(Color(.systemGray5))
                )

            Button {
                action()
            } label: {
                Image(systemName: "plus")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(Color.Label.white)
                    .frame(width: 36, height: 36)
                    .background(
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(Color.black)
                    )
            }
            .buttonStyle(.plain)
        }
    }
}

private struct GroupMembersCountView: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.system(size: 14, weight: .bold))
            .foregroundStyle(Color.Label.primary)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

private struct GroupMembersListView: View {
    let members: [GroupMember]

    var body: some View {
        VStack(spacing: 8) {
            ForEach(members) { member in
                GroupMemberRowView(member: member)
            }
        }
    }
}

private struct GroupMemberRowView: View {
    let member: GroupMember

    var body: some View {
        HStack(spacing: 12) {
            avatar
            memberInfo
            Spacer()
            actions
        }
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color(.systemGray5))
        )
    }

    private var avatar: some View {
        ZStack(alignment: .bottomTrailing) {
            Circle()
                .fill(Color.black)
                .frame(width: 36, height: 36)
                .overlay(
                    Image(systemName: "person.fill")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(Color.white)
                )

            Circle()
                .fill(member.isOnline ? Color.green : Color.orange)
                .frame(width: 8, height: 8)
                .overlay(
                    Circle()
                        .stroke(Color.white, lineWidth: 1)
                )
                .offset(x: 2, y: 2)
        }
    }

    private var memberInfo: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(member.name)
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(Color.Label.primary)

            Text("ID: \(member.staticId)")
                .font(.system(size: 12, weight: .regular))
                .foregroundStyle(Color.Label.secondary)
        }
    }

    private var actions: some View {
        HStack(spacing: 8) {
            Button {
                
            } label: {
                ZStack(alignment: .topTrailing) {
                    RoundedRectangle(cornerRadius: 6, style: .continuous)
                        .fill(Color(.systemGray4))
                        .frame(width: 32, height: 32)
                        .overlay(
                            Image(systemName: "bubble.left")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundStyle(Color.Label.primary)
                        )

                    if member.unreadCount > 0 {
                        Text("\(member.unreadCount)")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundStyle(Color.white)
                            .padding(4)
                            .background(
                                Circle()
                                    .fill(Color.black)
                            )
                            .offset(x: 6, y: -6)
                    }
                }
            }
            .buttonStyle(.plain)

            Button {
                
            } label: {
                RoundedRectangle(cornerRadius: 6, style: .continuous)
                    .fill(Color(.systemGray4))
                    .frame(width: 32, height: 32)
                    .overlay(
                        Image(systemName: "trash")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundStyle(Color.Label.primary)
                    )
            }
            .buttonStyle(.plain)
        }
    }
}

private struct GroupMessageAllButton: View {
    let title: String

    var body: some View {
        Button {
            
        } label: {
            Text(title)
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(Color.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Color.black)
                )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    GroupView()
        .environmentObject(AppRouter())
}
