//
//  BankTransactionView.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 03/02/2026.
//

import SwiftUI

struct BankTransactionsView: View {
    
    private let sampleList: [BankOperation] = BankOperation.sampleList
    
    internal var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("\(Texts.Bank.Transaction.title):")
                .font(.system(size: 20, weight: .bold))
                .padding(.horizontal, 16)
            
            LazyVStack(spacing: 8) {
                ForEach(sampleList.indices, id: \.self) { index in
                    TransactionRow(transaction: sampleList[index])
                    if index < sampleList.count - 1 {
                        Divider()
                            .padding(.horizontal, 12)
                    }
                }
            }
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(Color(.systemGray5))
            )
        }
    }
}

struct TransactionRow: View {
    private let transaction: BankOperation
    
    init(transaction: BankOperation) {
        self.transaction = transaction
    }

    internal var body: some View {
        HStack(alignment: .top, spacing: 12) {
            transaction.category.image
            transactionContent

            Spacer(minLength: 12)
            amountLabel
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
    }
    
    private var transactionContent: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(transaction.category.name)
                .font(.system(size: 18, weight: .bold))
            
            Text(DateFormatter.dayMonthYearTime.string(from: transaction.date))
                .font(.system(size: 16))
                .foregroundStyle(Color.LabelColors.labelSecondary)
        }
    }
    
    private var amountLabel: some View {
        Text("\(incomeSymbol)$ \( NumberFormatter.bankGrouping.string(from: NSNumber(value: transaction.amount)) ?? "\(transaction.amount)")")
            .font(.system(size: 18, weight: .bold))
            .foregroundStyle(transaction.category.foreground)
            .multilineTextAlignment(.trailing)
            .lineLimit(1)
            .minimumScaleFactor(0.5)
    }
    
    private var incomeSymbol: String {
        transaction.category.isIncome ? "+" : "-"
    }
}

#Preview {
    BankTransactionsView()
        .padding()
}
