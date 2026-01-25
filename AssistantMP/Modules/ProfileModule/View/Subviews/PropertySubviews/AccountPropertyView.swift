//
//  AccountPropertyView.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 23/01/2026.
//

import SwiftUI

struct AccountPropertyView: View {
    internal var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(Texts.Profile.Property.title)
                .font(.system(size: 22, weight: .bold))
                .padding(.horizontal, 8)
            
            sectionList
                .padding(.vertical, 20)
                .background(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Color(.systemGray5))
                )
        }
    }
    
    private var sectionList: some View {
        LazyVStack(spacing: 16) {
            ForEach(PropertyCategory.allCases) { category in
                if let items = PropertyItem.sampleSections[category], !items.isEmpty {
                    SectionBox(title: category.title) {
                        VStack(spacing: 0) {
                            ForEach(items.indices, id: \.self) { index in
                                AccountPropertyRow(
                                    item: items[index])
                                if index < items.count - 1 {
                                    Divider()
                                        .padding(.horizontal, 8)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

private struct SectionBox<Content: View>: View {
    let title: String
    @ViewBuilder let content: () -> Content
    
    internal var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(Color.LabelColors.labelPrimary)
                .padding(.horizontal, 18)
            
            content()
                .background(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(Color.BackColors.backDefault)
                )
                .padding(.horizontal, 10)
        }
    }
}

#Preview {
    AccountPropertyView()
}
