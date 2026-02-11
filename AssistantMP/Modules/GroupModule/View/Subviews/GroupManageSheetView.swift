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
        VStack(spacing: 20) {
            header
            createdSection
            memberSection
            instruction
            actionButtons
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
        .padding(.bottom, 8)
        .presentationDetents([.large])
        .presentationDragIndicator(.visible)
    }

    private var header: some View {
        Text(Texts.Group.ManageSheet.title)
            .font(.system(size: 18, weight: .bold))
            .foregroundStyle(Color.Label.primary)
            .frame(maxWidth: .infinity, alignment: .center)
    }

    private var createdSection: some View {
        VStack(spacing: 8) {
            Text(viewModel.createdTitleText)
                .font(.system(size: 14, weight: .bold))
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
                .font(.system(size: 14, weight: .bold))
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
            .font(.system(size: 12, weight: .regular))
            .foregroundStyle(Color.Label.secondary)
            .multilineTextAlignment(.center)
    }

    private var actionButtons: some View {
        VStack(spacing: 10) {
            Button {
                
            } label: {
                Text(Texts.Group.ManageSheet.createGroup)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
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
                    .padding(.vertical, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(Color(.systemGray4))
                    )
            }
            .buttonStyle(.plain)
        }
        .padding(.top, 8)
    }
}


private struct ManageGroupCardView: View {
    let items: [ManageGroupItem]
    @Binding var draggingItem: ManageGroupItem?
    var onMove: (_ source: IndexSet, _ destination: Int) -> Void

    var body: some View {
        VStack(spacing: 0) {
            ReorderableForEach(items, active: $draggingItem) { item in
                ManageGroupRowView(item: item)
                if item.id != items.last?.id {
                    Divider()
                        .background(Color(.systemGray3))
                }
            } moveAction: { from, to in
                onMove(from, to)
            }
        }
        .reorderableForEachContainer(active: $draggingItem)
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color(.systemGray5))
        )
    }
}

private struct ManageGroupRowView: View {
    let item: ManageGroupItem

    var body: some View {
        HStack(spacing: 8) {
            Text(item.title)
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(Color.Label.primary)

            if let leadingIcon = item.leadingIcon {
                leadingIcon.image
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(Color.Label.secondary)
            }

            Spacer()

            Text("\(item.count)")
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(Color.Label.secondary)

            item.trailingIcon.image
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(Color.black)
                .frame(width: 28, height: 28)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
    }
}

#Preview {
    GroupManageSheetView(viewModel: GroupViewModel())
}
