//
//  GroupManageSheetView.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 11/02/2026.
//

import SwiftUI
internal import UniformTypeIdentifiers

struct GroupManageSheetView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: GroupViewModel
    
    @State private var draggingCreatedGroup: ManageGroupItem?
    @State private var draggingMemberGroup: ManageGroupItem?

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 16) {
                createdSection
                memberSection
                instruction
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 8)
        }
        .safeAreaInset(edge: .top) {
            GroupManagementCustomNavBar()
        }
        .safeAreaInset(edge: .bottom) {
            actionButtons
        }
    }

    private var createdSection: some View {
        VStack(spacing: 8) {
            Text(viewModel.createdTitleText)
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(Color.Label.primary)

            ManageGroupCardView(
                items: viewModel.createdGroups,
                draggingItem: $draggingCreatedGroup
            ) { source, destination in
                withAnimation(.easeInOut(duration: 0.2)) {
                    viewModel.moveCreatedGroups(from: source, to: destination)
                }
            }
        }
    }

    private var memberSection: some View {
        VStack(spacing: 8) {
            Text(viewModel.memberTitleText)
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(Color.Label.primary)

            ManageGroupCardView(
                items: viewModel.memberGroups,
                draggingItem: $draggingMemberGroup
            ) { source, destination in
                withAnimation(.easeInOut(duration: 0.2)) {
                    viewModel.moveMemberGroups(from: source, to: destination)
                }
            }
        }
    }

    private var instruction: some View {
        Text(Texts.Group.ManageSheet.instruction)
            .font(.system(size: 14, weight: .regular))
            .foregroundStyle(Color.Label.secondary)
            .multilineTextAlignment(.center)
    }

    private var actionButtons: some View {
        VStack(spacing: 16) {
            Button {
                dismiss()
            } label: {
                Text(Texts.Group.ManageSheet.createGroup)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity)
                    .padding(16)
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(Color.black)
                    )
            }
            .buttonStyle(.plain)

            Button {
                dismiss()
            } label: {
                Text(Texts.Group.ManageSheet.cancel)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(Color.Label.primary)
                    .frame(maxWidth: .infinity)
                    .padding(16)
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(Color(.systemGray4))
                    )
            }
            .buttonStyle(.plain)
        }
        .padding([.bottom, .horizontal])
    }
}

#Preview {
    GroupManageSheetView(viewModel: GroupViewModel())
}
