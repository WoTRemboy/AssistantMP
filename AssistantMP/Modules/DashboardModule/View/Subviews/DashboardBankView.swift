//
//  DashboardBankView.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 22/01/2026.
//

import SwiftUI

struct DashboardBankView: View {
    
    @State private var didAnimate: Bool = false
    
    private let amount: Int = 12500000
    private var formattedAmount: String { NumberFormatter.bankGrouping.string(from: NSNumber(value: amount)) ?? "\(amount)" }
    
    internal var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            headerView
            cardView
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 16)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color(.systemGray5))
        )
    }
    
    private var headerView: some View {
        HStack(spacing: 10) {
            Circle()
                .fill(Color.gray)
                .frame(width: 24, height: 24)
            
            Text(Texts.Dashboard.Bank.title)
                .font(.system(size: 22, weight: .bold))
                .fontWeight(.semibold)
            
            Image.Dashboard.info
                .resizable()
                .frame(width: 24, height: 24)
                .padding(.horizontal, 6)
            
            Spacer()
            
            Text(Texts.Dashboard.more)
                .font(.system(size: 18, weight: .regular))
                .foregroundStyle(Color.accentColor)
        }
    }
    
    private var cardView: some View {
        HStack(spacing: 16) {
            amountView
            actionButton
        }
        .frame(maxWidth: .infinity)
    }
    
    private var amountView: some View {
        CountingText(value: didAnimate ? Double(amount) : 0)
            .font(.system(size: 18, weight: .bold))
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
        
            .padding(12)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color.white)
            )
    }
    
    private var actionButton: some View {
        Button {
            
        } label: {
            Text(Texts.Dashboard.Bank.action)
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(Color.LabelColors.labelReversed)
                .lineLimit(1)
            
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Color.black)
                )
                .foregroundStyle(.white)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    DashboardBankView()
}
