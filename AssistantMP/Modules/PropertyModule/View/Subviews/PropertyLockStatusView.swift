//
//  PropertyLockStatusView.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 02/02/2026.
//

import SwiftUI

struct PropertyLockStatusView: View {
    
    @ObservedObject private var viewModel: PropertyViewModel
    private let lockStatus: PropertyLock
    
    init(lockStatus: PropertyLock, viewModel: PropertyViewModel) {
        self.lockStatus = lockStatus
        self.viewModel = viewModel
    }
    
    internal var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                lockStatus.icon
                    .shadow(color: lockStatus.color, radius: 15, x: 0, y: 4)
                statusContent
            }
            toggleButton
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color(.systemGray6))
        )
    }
    
    private var statusContent: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(lockStatus.title)
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(Color.LabelColors.labelPrimary)
            
            Text(Texts.Property.status)
                .font(.system(size: 16, weight: .regular))
                .foregroundStyle(Color.LabelColors.labelSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var toggleButton: some View {
        Button {
            withAnimation(.smooth(duration: 0.25)) {
                viewModel.lockStatusToggle()
            }
        } label: {
            Text(lockStatus.actionTitleFull)
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(Color.LabelColors.labelReversed)
            
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Color.black)
                )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    PropertyLockStatusView(lockStatus: .locked, viewModel: PropertyViewModel())
}
