//
//  AccountPropertyRow.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 24/01/2026.
//

import SwiftUI

struct AccountPropertyRow: View {
    private let item: PropertyItem
    
    init(item: PropertyItem) {
        self.item = item
    }

    internal var body: some View {
        HStack(alignment: .center, spacing: 12) {
            SceletonView(.circle)
                .frame(width: 38, height: 38)
                .padding(.leading, 8)

            VStack(alignment: .leading, spacing: 8) {
                Text(item.title)
                    .font(.body.weight(.semibold))
                    .foregroundStyle(.primary)
                    .lineLimit(1)

                if let date = item.paymentDate {
                    timeLeftView(days: daysUntil(date), date: date)
                }
            }
        }
        .frame(maxWidth: .infinity, minHeight: 56, alignment: .leading)
        .padding(.vertical, 8)
    }

    private func timeLeftView(days: Int, date: Date) -> some View {
        HStack(spacing: 8) {
            AccountPillView(
                text: Date.daysRemaining(until: date),
                style: days <= 3 ? .warning : .info)
            daysLeftView(days: days, date: date)
        }
    }
    
    private func daysLeftView(days: Int, date: Date) -> some View {
        VStack(alignment: .leading) {
            AccountPropertyTimeLeftBar(
                fraction: min(1, max(0, CGFloat(days) / 30)),
                style: days <= 3 ? .warning : .info
            )
            .frame(width: 100)
            
            Text("\(Texts.Profile.Property.payment): \(DateFormatter.shortPayment.string(from: date))")
                .font(.system(size: 12, weight: .regular))
        }
    }
    
    private func daysUntil(_ date: Date) -> Int {
        let startOfToday = Calendar.current.startOfDay(for: Date())
        let startOfTarget = Calendar.current.startOfDay(for: date)
        let components = Calendar.current.dateComponents([.day], from: startOfToday, to: startOfTarget)
        return max(0, components.day ?? 0)
    }
}

#Preview {
    AccountPropertyRow(item: .sample)
        .frame(height: 70)
}
