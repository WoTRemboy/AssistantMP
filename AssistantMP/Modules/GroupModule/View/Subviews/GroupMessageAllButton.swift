//
//  GroupMessageAllButton.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 07/02/2026.
//

import SwiftUI

struct GroupMessageAllButton: View {
    private let title: String
    
    init(title: String) {
        self.title = title
    }

    internal var body: some View {
        Button {
            
        } label: {
            Text(title)
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(Color.Label.white)
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
