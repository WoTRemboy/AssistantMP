//
//  GroupAddMemberView.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 07/02/2026.
//

import SwiftUI

struct GroupAddMemberView: View {
    @Binding var text: String
    var action: () -> Void

    var body: some View {
        HStack(spacing: 8) {
            TextField(Texts.Group.addPlaceholder, text: $text)
                .font(.system(size: 16, weight: .regular))
                .foregroundStyle(Color.Label.primary)
                .keyboardType(.numberPad)
                .padding(.horizontal, 16)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(Color(.systemGray5))
                )

            Button {
                hideKeyboard()
                action()
            } label: {
                Image.Group.addPerson
                    .frame(width: 48, height: 48)
                    .background(
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(Color.black)
                    )
            }
            .buttonStyle(.plain)
        }
        .frame(height: 48)
    }
}

#Preview {
    GroupAddMemberView(text: .constant(""), action: {})
        .padding(.horizontal)
}
