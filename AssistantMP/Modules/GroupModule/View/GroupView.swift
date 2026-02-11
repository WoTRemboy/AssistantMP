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
            VStack(spacing: 16) {
                titleLabel
                GroupTabsView(viewModel: viewModel, selected: $viewModel.selectedCategory)
                GroupAddMemberView(
                    text: $viewModel.addMemberId,
                    action: viewModel.addMember
                )
                VStack(spacing: 6) {
                    GroupMembersCountView(text: viewModel.membersCountText)
                    GroupMembersListView(members: viewModel.visibleMembers)
                        .id(viewModel.selectedCategory)
                        .transition(.blurReplace)
                        .animation(.easeInOut(duration: 0.25), value: viewModel.selectedCategory)
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 16)
            .navigationBarHidden(true)
        }
        .safeAreaInset(edge: .bottom) {
            safeAreaBottomButton
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
    
    private var safeAreaBottomButton: some View {
        GroupMessageAllButton(title: Texts.Group.messageAll)
            .padding(.horizontal)
            .padding(.top, 8)
            .background(Color.Back.backDefault)
    }
}

private struct GroupMembersCountView: View {
    private let text: String
    
    init(text: String) {
        self.text = text
    }

    internal var body: some View {
        Text(text)
            .font(.system(size: 16, weight: .bold))
            .foregroundStyle(Color.Label.primary)
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .center)
            .contentTransition(.numericText())
    }
}

private struct GroupMembersListView: View {
    private let members: [GroupMember]
    
    init(members: [GroupMember]) {
        self.members = members
    }

    internal var body: some View {
        LazyVStack(spacing: 6) {
            ForEach(members) { member in
                GroupMemberRowView(member: member)
            }
        }
    }
}

#Preview {
    GroupView()
        .environmentObject(AppRouter())
}
