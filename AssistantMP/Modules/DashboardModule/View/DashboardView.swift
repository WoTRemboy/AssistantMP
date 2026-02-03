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
                .background(Color.BackColors.backDefault)
        }
        .safeAreaInset(edge: .top) {
            DashboardCustomNavBar(username: nil)
        }
        .alert(isPresented: $viewModel.paymentAlertShow) {
            paymentAlert
                .transition(.blurReplace.combined(with: .push(from: .bottom)))
        } background: {
            Rectangle()
                .fill(.primary.opacity(0.35))
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
            .foregroundStyle(Color.LabelColors.labelWhite)
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
    
    private var paymentAlert: some View {
        CustomPaymentWarning(
            title: "\(Texts.Property.address): \(viewModel.selectedProperty.title).",
            content: Texts.Property.warningShort,
            value: "\(Date.daysRemaining(until: viewModel.selectedProperty.paymentDate ?? .now))",
            titleError: Texts.Property.warningError,
            image: Image.Alert.warning) {
                viewModel.paymentAlertShowToggle()
            }
    }
}

#Preview {
    DashboardView()
        .environmentObject(AppRouter())
}
