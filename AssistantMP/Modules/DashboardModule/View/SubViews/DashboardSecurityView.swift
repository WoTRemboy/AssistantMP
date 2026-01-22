//
//  DashboardSecurityView.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 22/01/2026.
//

import SwiftUI

struct DashboardSecurityView: View {
    internal var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            headerView
            cardView
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
            
            Text(Texts.Dashboard.Security.title)
                .font(.system(size: 22, weight: .bold))
                .fontWeight(.semibold)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
        }
    }
    
    private var cardView: some View {
        HStack(spacing: 16) {
            passwordButton
            twoFactorButton
        }
        .frame(maxWidth: .infinity)
    }
    
    private var passwordButton: some View {
        Button {
            
        } label: {
            Text(Texts.Dashboard.Security.password)
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(Color.LabelColors.labelPrimary)
                .lineLimit(1)
                .minimumScaleFactor(0.3)
            
                .padding(12)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Color.white)
                )
        }
        .buttonStyle(.plain)
    }
    
    private var twoFactorButton: some View {
        Button {
            
        } label: {
            Text(Texts.Dashboard.Security.twoFactor)
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(Color.LabelColors.labelReversed)
                .lineLimit(1)
            
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Color.black)
                )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    DashboardSecurityView()
}
