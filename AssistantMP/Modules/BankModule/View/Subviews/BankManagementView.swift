//
//  BankManagementView.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 02/02/2026.
//

import SwiftUI

struct BankManagementView: View {
    
    @ObservedObject var viewModel: BankViewModel
    @State private var didAnimate: Bool = false
    private let amount = 12_500_000
    
    internal var body: some View {
        HStack(alignment: .center, spacing: 8) {
            balanceCard
            VStack(spacing: 8) {
                actionButton(for: .topUp) {}
                actionButton(for: .transfer) {
                    viewModel.openTransferAlert()
                }
            }
        }
        .frame(maxHeight: 112)
        .alert(isPresented: $viewModel.isTransferAlertPresented, onDismiss: {
            viewModel.closeTransferAlert()
        }) {
            transferAlertView
                .transition(.blurReplace.combined(with: .push(from: .bottom)))
        } background: {
            Color.black.opacity(0.35)
        }
    }
    
    private var balanceCard: some View {
        VStack(alignment: .center, spacing: 8) {
            countingText
                
            Text(Texts.Bank.balance)
                .font(.system(size: 18))
                .foregroundStyle(Color.LabelColors.labelSecondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .padding(.horizontal, 16)
        .padding(.vertical, 28)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color(.systemGray5))
        )
    }
    
    private var countingText: some View {
        CountingText(value: didAnimate ? Double(amount) : 0)
            .font(.system(size: 25, weight: .bold))
            .foregroundStyle(Color.LabelColors.labelPrimary)
            .lineLimit(1)
            .minimumScaleFactor(0.3)
        
            .onAppear {
                if !didAnimate {
                    withAnimation(.easeOut(duration: 0.8)) {
                        didAnimate = true
                    }
                }
            }
    }
    
    private func actionButton(for type: BankManagement, action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            HStack(spacing: 10) {
                type.image
                Text(type.title)
                    .font(.system(size: 18, weight: .bold))
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
            }
            .foregroundStyle(Color.LabelColors.labelWhite)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .contentShape(Rectangle())
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(type.color)
            )
        }
        .buttonStyle(.plain)
    }
    
    private var transferAlertView: some View {
        BankTransferAlertView(viewModel: viewModel)
    }
}

#Preview {
    BankManagementView(viewModel: BankViewModel())
        .padding(.horizontal, 8)
}
