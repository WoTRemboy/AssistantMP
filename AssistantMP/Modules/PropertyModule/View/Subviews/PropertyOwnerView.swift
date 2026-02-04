//
//  PropertyOwnerView.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 02/02/2026.
//

import SwiftUI

struct PropertyOwnerView: View {
    internal var body: some View {
        HStack(spacing: 12) {
            Image.Property.person
                
            VStack(alignment: .leading, spacing: 4) {
                Text(User.sample.name)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(Color.Label.primary)
                
                Text(Texts.Property.owner)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundStyle(Color.Label.secondary)
            }
            Spacer()
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color(.systemGray6))
        )
    }
}

#Preview {
    PropertyOwnerView()
}
