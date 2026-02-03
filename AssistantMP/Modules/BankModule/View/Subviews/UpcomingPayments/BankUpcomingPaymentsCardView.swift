//
//  BankUpcomingPaymentsCardView.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 03/02/2026.
//

import SwiftUI

struct BankUpcomingPaymentCard: View {
    
    @Binding var popoverContext: (PropertyCategory, PropertyItem)?
    @State private var didAnimate: Bool = false
    
    private let category: PropertyCategory
    private let item: PropertyItem
    
    private let daysLeft: Int
    private let daysLeftText: String
    private let daysLeftWarning: PropertyWarningStyle
    
    init(category: PropertyCategory, item: PropertyItem, popoverContext: Binding<(PropertyCategory, PropertyItem)?> = .constant(nil)) {
        self.category = category
        self.item = item
        self._popoverContext = popoverContext
        
        self.daysLeft = Date.daysUntil(item.paymentDate ?? .now)
        self.daysLeftText = Date.daysRemaining(until: item.paymentDate ?? .now)
        self.daysLeftWarning = Date.daysUntil(item.paymentDate ?? .now) <= 3 ? .warning : .info
    }
    
    private var titleText: String {
        switch category {
        case .home: return "Дом"
        case .business: return item.title
        case .transport: return item.title
        }
    }
    
    internal var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            titleView
            timeLeftAmountView
        }
        .padding(14)
        .background {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color.BackColors.backDefault)
        }
        .frame(width: 160, height: 180)
    }
    
    private var titleView: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(titleText)
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(Color.LabelColors.labelPrimary)
                .lineLimit(3)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
                .layoutPriority(1)
            
            if let subtitle = item.address {
                Text(subtitle)
                    .font(.system(size: 14))
                    .foregroundStyle(Color.LabelColors.labelSecondary)
                    .lineLimit(3)
                    .truncationMode(.middle)
                    .layoutPriority(0)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
    
    private var timeLeftAmountView: some View {
        VStack(alignment: .leading, spacing: 5) {
            Button {
                popoverContext = (category, item)
            } label: {
                daysLeftView
            }
            .buttonStyle(.plain)
            .popover(item: Binding<StablePopoverItem?>(
                get: {
                    popoverContext.map { StablePopoverItem(category: $0.0, item: $0.1) }
                },
                set: { newValue in
                    if let value = newValue { popoverContext = (value.category, value.item) } else { popoverContext = nil }
                }
            )) { value in
                WarningPopover(category: value.category, item: value.item)
                    .presentationCompactAdaptation(.popover)
            }
            
            timeLeftBar
            
            if let amount = item.paymentAmount {
                CountingText(value: didAnimate ? Double(amount) : 0)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(Color.LabelColors.labelGreyDark)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                
                    .padding(.top, 8)
                    .onAppear {
                        if !didAnimate {
                            withAnimation(.easeOut(duration: 0.8)) {
                                didAnimate = true
                            }
                        }
                    }
            }
        }
    }
    
    private var daysLeftView: some View {
        HStack(spacing: 4) {
            Image.Profile.clock
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(width: 16, height: 16)
            
            Text(daysLeftText)
                .font(.system(size: 14, weight: .bold))
                
        }
        .foregroundStyle(daysLeftWarning.foreground)
    }
    
    private var timeLeftBar: some View {
        let days = CGFloat(Date.daysUntil(item.paymentDate ?? .now))
        
        return PropertyTimeLeftBar(
            fraction: min(1, max(0, days / 30)),
            height: 7,
            style: daysLeftWarning)
    }
    
    struct StablePopoverItem: Identifiable, Equatable {
        let category: PropertyCategory
        let item: PropertyItem
        var id: String { "\(category)-\(item.id)" }
    }
}

#Preview {
    BankUpcomingPaymentCard(category: .home, item: .sample, popoverContext: .constant(nil))
}
