//
//  BankUpcomingPaymentsView.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 03/02/2026.
//

import SwiftUI

struct BankUpcomingPaymentsView: View {    
    
    @State private var popoverContext: PopoverIdentifiable?

    internal var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            titleView
            cardsScrollView
        }
        .padding(.vertical, 16)
        .background {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color(.systemGray5))
        }
    }
    
    private var titleView: some View {
        Text(Texts.Bank.upcomingPayments)
            .font(.system(size: 20, weight: .bold))
            .foregroundStyle(Color.LabelColors.labelPrimary)
            .padding(.horizontal, 16)
    }
    
    private var cardsScrollView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(Array(sortedItems.enumerated()), id: \.element.1.id) { _, element in
                    let category = element.0
                    let item = element.1
                    BankUpcomingPaymentCard(
                        category: category,
                        item: item,
                        popoverContext: $popoverContext
                    )
                }
            }
            .padding(.horizontal, 16)
        }
    }
    
    private var sortedItems: [(PropertyCategory, PropertyItem)] {
        let sections = PropertyItem.sampleSections
        let categories: [PropertyCategory] = [.home, .business]

        let flattened: [(PropertyCategory, PropertyItem)] = categories.flatMap { category in
            (sections[category] ?? [])
                .compactMap { item in
                    guard item.paymentDate != nil else { return nil }
                    return (category, item)
                }
        }

        return flattened.sorted { lhs, rhs in
            let lDays = lhs.1.paymentDate.map { Date.daysUntil($0) } ?? Int.max
            let rDays = rhs.1.paymentDate.map { Date.daysUntil($0) } ?? Int.max
            if lDays == rDays {
                return lhs.0 == .home && rhs.0 == .business
            }
            return lDays < rDays
        }
    }
}

struct WarningPopover: View {
    let category: PropertyCategory
    let item: PropertyItem

    private var daysLeft: Int {
        guard let date = item.paymentDate else { return 0 }
        return Date.daysUntil(date)
    }

    internal var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Image.Alert.warning
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
            
            VStack(alignment: .leading, spacing: 0) {
                Text(Texts.Bank.Transaction.warning)
                    .font(.system(size: 14, weight: .bold))
                
                Text("\(Texts.Bank.Transaction.remaining) \(Date.daysRemaining(until: item.paymentDate ?? .now))")
                    .font(.system(size: 14, weight: .regular))
            }
            .foregroundStyle(Color.LabelColors.labelPrimary)
        }
        .padding(16)
    }
}

#Preview {
    BankUpcomingPaymentsView()
        .padding()
}
