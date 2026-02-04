//
//  BankViewModel.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 04/02/2026.
//

import SwiftUI
import Combine

@MainActor
final class BankViewModel: ObservableObject {
    @Published var isTransferAlertPresented: Bool = false
    @Published var transferAlertState: BankTransferAlertState = .empty
    @Published var transferIdText: String = ""
    @Published var transferAmountText: String = ""

    var canSend: Bool {
        transferAlertState == .filled && !transferIdText.isEmpty && !transferAmountText.isEmpty
    }

    var shouldShowAccessory: Bool {
        switch transferAlertState {
        case .loading, .filled:
            return true
        case .empty:
            return !transferIdText.isEmpty
        }
    }

    func openTransferAlert() {
        transferAlertState = .empty
        isTransferAlertPresented = true
    }

    func closeTransferAlert() {
        isTransferAlertPresented = false
        Task {
            try? await Task.sleep(for: .seconds(0.2))
            guard !isTransferAlertPresented else { return }
            transferAlertState = .empty
            transferIdText = ""
            transferAmountText = ""
        }
    }

    func updateIdText(_ value: String) {
        let filtered = filteredDigits(from: value)
        if filtered != transferIdText {
            transferIdText = filtered
        }
        if transferAlertState != .loading {
            transferAlertState = .empty
        }
    }

    func updateAmountText(_ value: String) {
        let formatted = formattedAmount(from: value)
        if formatted != transferAmountText {
            transferAmountText = formatted
        }
    }

    func searchUser() {
        guard !transferIdText.isEmpty, transferAlertState != .loading else { return }
        Task {
            transferAlertState = .loading
            try? await Task.sleep(for: .seconds(0.8))
            transferAlertState = .filled
        }
    }

    func sendTransfer() {
        guard canSend else { return }
        Task {
            transferAlertState = .loading
            try? await Task.sleep(for: .seconds(0.8))
            closeTransferAlert()
        }
    }

    private func filteredDigits(from value: String) -> String {
        value.filter { $0.isNumber }
    }

    private func formattedAmount(from value: String) -> String {
        let digits = filteredDigits(from: value)
        guard !digits.isEmpty else { return "" }
        let intValue = Int(digits) ?? 0
        return NumberFormatter.bankGrouping.string(from: NSNumber(value: intValue)) ?? digits
    }
}
