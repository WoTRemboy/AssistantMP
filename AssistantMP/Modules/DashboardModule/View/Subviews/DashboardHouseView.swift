//
//  DashboardHouseView.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 21/01/2026.
//

import SwiftUI

struct DashboardHouseView: View {
    
    @ObservedObject private var viewModel: DashboardViewModel
    @EnvironmentObject private var appRouter: AppRouter
        
    init(viewModel: DashboardViewModel) {
        self.viewModel = viewModel
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
        .sensoryFeedback(.selection, trigger: viewModel.selectedProperty.lockStatus)
    }
    
    private var headerView: some View {
        HStack(spacing: 10) {
            Circle()
                .fill(Color.gray)
                .frame(width: 24, height: 24)

            Text(Texts.Dashboard.House.title)
                .font(.system(size: 22, weight: .bold))
                .fontWeight(.semibold)

            paymentAlertButton
            Spacer()
            moreButton
        }
    }
    
    private var paymentAlertButton: some View {
        Button {
            viewModel.paymentAlertShowToggle()
        } label: {
            Image.Dashboard.info
                .resizable()
                .frame(width: 24, height: 24)
                .padding(.horizontal, 6)
        }
        .buttonStyle(.plain)
    }
    
    private var moreButton: some View {
        Button {
            appRouter.push(.property, in: .main)
        } label: {
            Text(Texts.Dashboard.more)
                .font(.system(size: 18, weight: .regular))
                .foregroundStyle(Color.accentColor)
        }
        .contentShape(.rect)
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
        viewModel.selectedProperty.lockStatus?.icon
            .resizable()
            .scaledToFit()
            .frame(width: 38, height: 38)
            .shadow(color: viewModel.selectedProperty.lockStatus?.color ?? .gray, radius: 15, x: 0, y: 4)
    }
    
    private var propertyContent: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(viewModel.selectedProperty.lockStatus?.title ?? PropertyLock.unlocked.title)
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(Color.LabelColors.labelPrimary)
            
            Text(viewModel.selectedProperty.title)
                .font(.system(size: 14, weight: .regular))
                .foregroundStyle(Color.LabelColors.labelSecondary)
                .lineLimit(1)
                .truncationMode(.middle)
        }
    }
    
    private var actionButton: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.2)) {
                viewModel.selectedProperty.lockStatus?.toggle()
            }
        } label: {
            Text(viewModel.selectedProperty.lockStatus?.actionTitle ?? "")
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(Color.LabelColors.labelReversed)
                .lineLimit(1)
            
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Color.black)
                )
                .foregroundStyle(.white)
        }
        .layoutPriority(2)
        .buttonStyle(.plain)
    }
}

#Preview {
    DashboardHouseView(viewModel: DashboardViewModel())
        .environmentObject(AppRouter())
}
