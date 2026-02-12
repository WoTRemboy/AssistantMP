//
//  ManageGroupRowView.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 12/02/2026.
//

import SwiftUI

struct ManageGroupRowView: View {
    let item: ManageGroupItem

    var body: some View {
        HStack(spacing: 8) {
            Text(item.title)
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(Color.Label.primary)

            if let leadingIcon = item.leadingIcon {
                leadingIcon.image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
            }

            Spacer()

            Text("\(item.count)")
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(Color.Label.secondary)
                .padding(.trailing, 8)

            item.trailingIcon.image
                .resizable()
                .scaledToFit()
                .frame(width: 32, height: 32)
        }
        .padding(16)
    }
}

#Preview {
    GroupManageSheetView(viewModel: GroupViewModel())
}
