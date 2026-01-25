//
//  AccountBankView.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 23/01/2026.
//

import SwiftUI

struct AccountBankView: View {
    @State private var didAnimate: Bool = false

    private let user: User
    
    init(user: User) {
        self.user = user
    }

    internal var body: some View {
        HStack(spacing: 12) {
            balanceCard(title: "\(Texts.Profile.cash):", amount: user.cash)
            balanceCard(title: "\(Texts.Profile.bank):", amount: user.bank)
        }
        .onAppear {
            if !didAnimate {
                withAnimation(.easeOut(duration: 0.8)) {
                    didAnimate = true
                }
            }
        }
    }

    private func balanceCard(title: String, amount: Int) -> some View {
        VStack(alignment: .center, spacing: 6) {
            Text(title)
                .font(.system(size: 18, weight: .regular))
                .foregroundStyle(Color.LabelColors.labelSecondary)
            
            CountingText(value: didAnimate ? Double(amount) : 0)
                .font(.system(size: 25, weight: .bold))
                .foregroundStyle(.primary)
        }
        .frame(maxWidth: .infinity)
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color(.systemGray5))
        )
    }
}

#Preview {
    AccountBankView(user: .sample)
}
