//
//  GroupTabsView.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 07/02/2026.
//

import SwiftUI

struct GroupTabsView: View {
    @ObservedObject var viewModel: GroupViewModel
    @Binding var selected: GroupCategory
    
    @Namespace private var selectionNamespace
    @State private var isManagingGroupsPresented = false
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    setupButton
                    cells(proxy: proxy)
                        .background(
                            RoundedRectangle(cornerRadius: 6, style: .continuous)
                                .fill(Color(.systemGray5))
                        )
                }
            }
            .onAppear {
                proxy.scrollTo(selected, anchor: .center)
            }
            .onChange(of: selected) { _, _ in
                withAnimation(.easeInOut(duration: 0.2)) {
                    proxy.scrollTo(selected, anchor: .center)
                }
            }
        }
        .sheet(isPresented: $isManagingGroupsPresented) {
            GroupManageSheetView(viewModel: viewModel)
        }
    }
    
    private var setupButton: some View {
        Button {
            isManagingGroupsPresented = true
        } label: {
            Image.Group.setup
        }
        .contentShape(.rect)
        .buttonStyle(.plain)
    }
    
    private func cells(proxy: ScrollViewProxy) -> some View {
        HStack(spacing: 0) {
            ForEach(Array(GroupCategory.allCases), id: \.self) { category in
                Button {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        selected = category
                        proxy.scrollTo(category, anchor: .center)
                    }
                } label: {
                    cellContent(for: category)
                }
                .buttonStyle(.plain)
                .id(category)
            }
        }
    }
    
    private func cellContent(for category: GroupCategory) -> some View {
        let isSelected = selected == category
        return ZStack {
            if isSelected {
                RoundedRectangle(cornerRadius: 6, style: .continuous)
                    .fill(Color.black)
                    .matchedGeometryEffect(id: "groupTabSelection", in: selectionNamespace)
            }

            HStack(spacing: 2) {
                Text(category.title)
                    .font(.system(size: 16, weight:  .bold))
                    .foregroundStyle(isSelected ? Color.Label.white : Color.Label.primary)

                if category.showsNotification {
                    Image.Group.notification
                }
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    GroupTabsView(viewModel: GroupViewModel(), selected: .constant(.work))
        .frame(height: 42)
}
