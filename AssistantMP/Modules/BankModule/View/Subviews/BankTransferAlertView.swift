//
//  BankTransferAlertView.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 04/02/2026.
//

import SwiftUI

enum BankTransferAlertState {
    case empty
    case filled
    case loading
}

struct BankTransferAlertView: View {
    @ObservedObject var viewModel: BankViewModel

    internal var body: some View {
        VStack(spacing: 0) {
            Text(Texts.Bank.Transfer.title)
                .font(.system(size: 19, weight: .bold))
                .foregroundStyle(Color.Label.primary)
                .padding(.top, 16)
                .padding(.bottom, 12)

            VStack(spacing: 12) {
                topRow
                amountField
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 16)

            Divider()
                .foregroundStyle(Color(.systemGray4))

            bottomActions
        }
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(Color.Back.primary)
        )
        .padding(.horizontal, 24)
        .frame(height: 240)
    }

    private var topRow: some View {
        HStack(spacing: 10) {
            TextField(
                "",
                text: idBinding,
                prompt: Text(Texts.Bank.Transfer.idPlaceholder)
                    .foregroundStyle(Color.Label.placeholder)
            )
            .font(.system(size: 18, weight: .medium))
            .foregroundStyle(Color.Label.primary)
            .keyboardType(.numberPad)
            .lineLimit(1)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            .padding(.vertical, 14)
            .padding(.horizontal, 16)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(Color(.systemGray5))
            )
            .disabled(viewModel.transferAlertState == .loading)

            if viewModel.shouldShowAccessory {
                statusAccessory
                    .transition(statusTransition)
            }
        }
        .animation(.spring(response: 0.35, dampingFraction: 0.8), value: viewModel.transferIdText.isEmpty)
        .animation(.spring(response: 0.35, dampingFraction: 0.8), value: viewModel.transferAlertState)
    }

    private var amountField: some View {
        HStack(spacing: 8) {
            Text("$")
                .font(.system(size: 18, weight: .medium))
                .foregroundStyle(amountColor)

            TextField(
                "",
                text: amountBinding,
                prompt: Text(Texts.Bank.Transfer.amountPlaceholder)
                    .foregroundStyle(Color.Label.placeholder)
            )
            .font(.system(size: 18, weight: .medium))
            .foregroundStyle(Color.Label.primary)
            .keyboardType(.numberPad)
            .lineLimit(1)
            .disabled(viewModel.transferAlertState == .loading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 14)
        .padding(.horizontal, 16)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color(.systemGray5))
        )
    }

    private var statusAccessory: some View {
        ZStack {
            switch viewModel.transferAlertState {
            case .loading:
                ProgressView()
                    .progressViewStyle(.circular)
                    .tint(Color.Label.primary)
                    .frame(width: 28, height: 28)
                    .transition(statusTransition)
            case .filled:
                userBadge
                    .transition(statusTransition)
            case .empty:
                Button {
                    viewModel.searchUser()
                } label: {
                    searchIcon
                }
                .buttonStyle(.plain)
                .transition(statusTransition)
            }
        }
    }

    private var statusTransition: AnyTransition {
        .asymmetric(
            insertion: .scale.combined(with: .opacity),
            removal: .scale.combined(with: .opacity)
        )
    }

    private var userBadge: some View {
        HStack(spacing: 5) {
            ZStack {
                Circle()
                    .fill(Color(.systemGray5))
                    .frame(width: 42, height: 42)
                Image.Profile.placeholder
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
            }

            Text(Texts.Bank.Transfer.userName)
                .font(.system(size: 17, weight: .medium))
                .foregroundStyle(Color.Label.primary)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
                .truncationMode(.middle)
                .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: 200, maxHeight: 42)
    }

    private var searchIcon: some View {
        ZStack {
            Circle()
                .fill(Color(.systemGray5))
                .frame(width: 42, height: 42)
            
            Image.General.magnifyingGlass
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(Color.Label.primary)
        }
        
    }

    private var idBinding: Binding<String> {
        Binding(
            get: { viewModel.transferIdText },
            set: { viewModel.updateIdText($0) }
        )
    }

    private var amountBinding: Binding<String> {
        Binding(
            get: { viewModel.transferAmountText },
            set: { viewModel.updateAmountText($0) }
        )
    }

    private var bottomActions: some View {
        HStack(spacing: 0) {
            Button {
                viewModel.closeTransferAlert()
            } label: {
                Text(Texts.Bank.Transfer.cancel)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(Color.Label.primary)
                    .frame(maxWidth: .infinity)
                    .frame(height: 52)
                    .contentShape(Rectangle())
            }

            Rectangle()
                .fill(Color(.systemGray4))
                .frame(width: 1)

            Button {
                guard viewModel.canSend else { return }
                viewModel.sendTransfer()
            } label: {
                Text(Texts.Bank.Transfer.send)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(sendColor)
                    .frame(maxWidth: .infinity)
                    .frame(height: 52)
                    .contentShape(Rectangle())
            }
            .disabled(!viewModel.canSend)
        }
    }

    private var amountColor: Color {
        viewModel.transferAmountText.isEmpty ? Color.Label.placeholder : Color.Label.primary
    }

    private var sendColor: Color {
        viewModel.canSend ? Color.Label.primary : Color.Label.disable
    }
}

#Preview {
    let viewModel = BankViewModel()
    BankTransferAlertView(viewModel: viewModel)
        .padding(.vertical, 24)
        .background(Color.Back.backDefault)
}
