//
//  DashboardView.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 20/01/2026.
//

import SwiftUI

struct DashboardView: View {
    internal var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 16) {
                groupTiles
                DashboardHouseView(type: .locked)
                DashboardBankView()
                DashboardMarketView()
                DashboardReferalView()
                DashboardSecurityView()
            }
            .padding(.horizontal)
        }
    }
    
    private var groupTiles: some View {
        HStack {
            ForEach(DashboardGroup.allCases, id: \.self) { type in
                DashboardGroupTile(type: type, notification: true)
            }
        }
    }
}

#Preview {
    DashboardView()
}
