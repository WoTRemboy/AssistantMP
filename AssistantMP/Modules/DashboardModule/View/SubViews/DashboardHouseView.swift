//
//  DashboardHouseView.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 21/01/2026.
//

import SwiftUI

struct DashboardHouseView: View {
    
    private let type: DashboardHouse
    
    init(type: DashboardHouse) {
        self.type = type
    }
    
    internal var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            headerView
            cardView
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(Color.white)
                )
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

            Text(Texts.Dashboard.House.title)
                .font(.system(size: 22, weight: .bold))
                .fontWeight(.semibold)

            Image.Dashboard.info
                .resizable()
                .frame(width: 24, height: 24)
                .padding(.horizontal, 6)

            Spacer()

            Text(Texts.Dashboard.House.more)
                .font(.system(size: 18, weight: .regular))
                .foregroundStyle(Color.accentColor)
        }
    }
    
    private var cardView: some View {
        HStack(spacing: 12) {
            icon
            propertyContent

            Spacer()
            actionButton
        }
    }
    
    private var icon: some View {
        type.icon
            .resizable()
            .scaledToFit()
            .frame(width: 38, height: 38)
            .shadow(color: type.color, radius: 15, x: 0, y: 4)
    }
    
    private var propertyContent: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(type.title)
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(Color.LabelColors.labelPrimary)
            
            Text("Центральная, 42")
                .font(.system(size: 14, weight: .regular))
                .foregroundStyle(Color.LabelColors.labelSecondary)
                .lineLimit(1)
        }
    }
    
    private var actionButton: some View {
        Button {
            
        } label: {
            Text(type.actionTitle)
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(Color.LabelColors.labelReversed)
                .lineLimit(1)
            
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .fill(Color.black)
                )
                .foregroundStyle(.white)
        }
        .layoutPriority(2)
        .buttonStyle(.plain)
    }
}

#Preview {
    DashboardHouseView(type: .locked)
}
