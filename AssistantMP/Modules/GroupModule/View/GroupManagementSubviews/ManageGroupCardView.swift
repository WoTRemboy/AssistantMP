//
//  ManageGroupCardView.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 12/02/2026.
//

import SwiftUI

struct ManageGroupCardView: View {
    let items: [ManageGroupItem]
    @Binding var draggingItem: ManageGroupItem?
    var onMove: (_ source: IndexSet, _ destination: Int) -> Void

    var body: some View {
        LazyVStack(spacing: 0) {
            ReorderableForEach(items, active: $draggingItem) { item in
                ManageGroupRowView(item: item)
                    .background(
                        Color(.systemGray5)
                    )
                if item.id != items.last?.id {
                    Divider()
                        .background(Color(.systemGray3))
                        .padding(.horizontal, 16)
                        .background(Color(.systemGray5))
                }
            } preview: { _ in
            } moveAction: { from, to in
                onMove(from, to)
            }
        }
        .reorderableForEachContainer(active: $draggingItem)
        .clipShape(.rect(cornerRadius: 16))
    }
}

#Preview {
    GroupManageSheetView(viewModel: GroupViewModel())
}
