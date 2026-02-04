//
//  BankUpcomingPaymentsCardView.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 03/02/2026.
//

import SwiftUI

struct BankUpcomingPaymentCard: View {
    
    @Binding var popoverContext: PopoverIdentifiable?
    @Binding var didShowAutoPopover: Bool
    @State private var didAnimate: Bool = false
    @State private var autoPopoverTask: Task<Void, Never>?
    
    private let category: PropertyCategory
    private let item: PropertyItem
    private let isFirst: Bool
    
    private let daysLeft: Int
    private let daysLeftText: String
    private let daysLeftWarning: PropertyWarningStyle
    
    init(
        category: PropertyCategory,
        item: PropertyItem,
        isFirst: Bool = false,
        popoverContext: Binding<PopoverIdentifiable?> = .constant(nil),
        didShowAutoPopover: Binding<Bool> = .constant(false)
    ) {
        self.category = category
        self.item = item
        self.isFirst = isFirst
        self._popoverContext = popoverContext
        self._didShowAutoPopover = didShowAutoPopover
        
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

    private var isPopoverPresented: Bool {
        popoverContext?.category == category && popoverContext?.item.id == item.id
    }
    
    internal var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            titleView
            timeLeftAmountView
        }
        .padding(14)
        .background {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color.Back.backDefault)
        }
        .frame(width: 160, height: 180)
        .onAppear {
            guard isFirst, !didShowAutoPopover, popoverContext == nil else { return }
            didShowAutoPopover = true
            autoPopoverTask?.cancel()
            autoPopoverTask = Task {
                try? await Task.sleep(for: .milliseconds(250))
                guard !Task.isCancelled else { return }
                popoverContext = PopoverIdentifiable(category: category, item: item)
            }
        }
        .onDisappear {
            autoPopoverTask?.cancel()
            autoPopoverTask = nil
        }
    }
    
    private var titleView: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(titleText)
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(Color.Label.primary)
                .lineLimit(3)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
                .layoutPriority(1)
            
            if let subtitle = item.address {
                Text(subtitle)
                    .font(.system(size: 14))
                    .foregroundStyle(Color.Label.secondary)
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
                if popoverContext == nil || isPopoverPresented {
                    popoverContext = PopoverIdentifiable(category: category, item: item)
                }
            } label: {
                daysLeftView
            }
            .buttonStyle(.plain)
            .disabled(popoverContext != nil && !isPopoverPresented)
            .popover(
                isPresented: Binding(
                    get: {
                        isPopoverPresented
                    },
                    set: { isPresented in
                        if !isPresented {
                            popoverContext = nil
                        }
                    }
                ),
                attachmentAnchor: .rect(.bounds),
                arrowEdge: .bottom
            ) {
                WarningPopover(category: category, item: item)
                    .presentationCompactAdaptation(.popover)
            }
            
            timeLeftBar
            
            if let amount = item.paymentAmount {
                CountingText(value: didAnimate ? Double(amount) : 0)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(Color.Label.greyDark)
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
}

#Preview {
    BankUpcomingPaymentCard(category: .home, item: .sample)
}
