//
//  DashboardGroupTile.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 21/01/2026.
//

import SwiftUI

struct DashboardGroupTile: View {
    
    private let type: DashboardGroup
    private let notification: Bool
    
    init(type: DashboardGroup, notification: Bool) {
        self.type = type
        self.notification = notification
    }
    
    internal var body: some View {
        ZStack(alignment: .top) {
            image
            titleLabel
        }
        .padding([.horizontal, .top], 8)
        
        .background {
            RoundedRectangle(cornerRadius: 5, style: .continuous)
                .fill(Color.LabelColors.labelDisable)
        }
        .mask {
            RoundedRectangle(cornerRadius: 5, style: .continuous)
        }
        .overlay(alignment: .topTrailing) {
            if notification {
                notificationIcon
            }
        }
    }
    
    private var titleLabel: some View {
        Text(type.title)
            .font(.system(size: 20, weight: .medium))
            .foregroundStyle(Color.LabelColors.labelPrimary)
            .lineLimit(2)
            .multilineTextAlignment(.center)
    }
    
    private var image: some View {
        type.image
            .resizable()
            .scaledToFit()
            .offset(x: type.offset.x, y: type.offset.y)
            .frame(height: 120)
    }
    
    private var notificationIcon: some View {
        Image.Dashboard.notification
            .offset(x: 5, y: -5)
    }
}

#Preview {
    HStack {
        DashboardGroupTile(type: .jobs, notification: true)
        DashboardGroupTile(type: .games, notification: true)
        DashboardGroupTile(type: .friends, notification: true)
    }
}
