//
//  DashboardView.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 20/01/2026.
//

import SwiftUI

struct DashboardView: View {
    
    @StateObject private var viewModel = DashboardViewModel()
    
    internal var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 16) {
                groupTiles
                DashboardHouseView(viewModel: viewModel)
                DashboardBankView()
                DashboardMarketView()
                DashboardReferalView()
                DashboardSecurityView()
            }
            .padding(.horizontal)
        }
        .safeAreaInset(edge: .bottom) {
            bottomActionBar
                .background(Color.Back.backDefault)
        }
        .safeAreaInset(edge: .top) {
            DashboardCustomNavBar(username: nil)
        }
    }
    
    private var groupTiles: some View {
        HStack {
            ForEach(DashboardGroup.allCases, id: \.self) { type in
                DashboardGroupTile(type: type, notification: true)
            }
        }
    }
    
    private var bottomActionBar: some View {
        Button {
            
        } label: {
            HStack(spacing: 10) {
                Image.Dashboard.currency
                Text(Texts.Dashboard.wallet)
                    .font(.system(size: 18, weight: .bold))
            }
            .foregroundStyle(Color.Label.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .contentShape(Rectangle())
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color.black)
            )
        }
        .buttonStyle(.plain)
        .padding(.horizontal)
        .padding(.top, 8)
    }
}

#Preview {
    DashboardView()
        .environmentObject(AppRouter())
}
