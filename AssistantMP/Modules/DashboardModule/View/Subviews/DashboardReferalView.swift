//
//  DashboardReferalView.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 22/01/2026.
//

import SwiftUI

struct DashboardReferalView: View {
    internal var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            headerView
            actionButton
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 16)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color(.systemGray5))
        )
    }
    
    private var headerView: some View {
        HStack(spacing: 10) {
            Circle()
                .fill(Color.gray)
                .frame(width: 24, height: 24)
            
            Text(Texts.Dashboard.Referal.title)
                .font(.system(size: 22, weight: .bold))
                .fontWeight(.semibold)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            
            Spacer()
            
            Text(Texts.Dashboard.more)
                .font(.system(size: 18, weight: .regular))
                .foregroundStyle(Color.accentColor)
        }
    }
    
    private var actionButton: some View {
        Button {
            
        } label: {
            actionButtonView
        }
        .buttonStyle(.plain)
    }
    
    private var actionButtonView: some View {
        HStack(spacing: 10) {
            Image.Dashboard.Referal.share
            
            Text(Texts.Dashboard.Referal.link)
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(Color.LabelColors.labelPrimary)
                .lineLimit(1)
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color.BackColors.backDefault)
        )
    }
}

#Preview {
    DashboardReferalView()
}
