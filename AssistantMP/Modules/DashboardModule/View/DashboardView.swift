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
            groupTiles
            dashboardHouseView
            dashboardBankView
        }
    }
    
    private var groupTiles: some View {
        HStack {
            ForEach(DashboardGroup.allCases, id: \.self) { type in
                DashboardGroupTile(type: type, notification: true)
            }
        }
        .padding(.horizontal)
    }
    
    private var dashboardHouseView: some View {
        DashboardHouseView(type: .locked)
            .padding(.horizontal)
    }
    
    private var dashboardBankView: some View {
        DashboardBankView()
            .padding(.horizontal)
    }
}

#Preview {
    DashboardView()
}
