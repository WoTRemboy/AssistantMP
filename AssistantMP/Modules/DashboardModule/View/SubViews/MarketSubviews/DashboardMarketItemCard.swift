//
//  MarketItemCard.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 22/01/2026.
//

import SwiftUI

struct MarketItemCard: View {
    
    private let item: MarketItem
    private let mode: MarketSegment
    
    init(item: MarketItem, mode: MarketSegment) {
        self.item = item
        self.mode = mode
    }

    internal var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            previewView
            if mode == .general {
                generalItem
            } else {
                saleItem
            }
        }
    }
    
    private var previewView: some View {
        ZStack(alignment: mode == .general ? .bottomLeading : .bottomTrailing) {
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(Color.BackColors.backDefault)
                .frame(width: 130, height: 120)

            if mode == .general {
                quantityView
            } else {
                removeButton
            }
        }
    }
    
    private var quantityView: some View {
        Text("\(item.quantity) \(Texts.Dashboard.Market.count)")
            .font(.system(size: 12, weight: .regular))
            .lineLimit(1)
            .minimumScaleFactor(0.5)
        
            .padding(.vertical, 3)
            .padding(.horizontal, 8)
        
            .background {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color(.systemGray5))
            }
            .padding(8)
    }
    
    private var removeButton: some View {
        Image.Dashboard.Market.remove
            .padding(8)
            .background {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color(.systemGray5))
            }
            .padding(8)
    }
    
    private var generalItem: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("$\( NumberFormatter.bankGrouping.string(from: NSNumber(value: item.price)) ?? "\(item.price)")")
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(Color.LabelColors.labelPrimary)
                .minimumScaleFactor(0.5)
            
            Text(item.title)
                .font(.system(size: 14, weight: .regular))
                .foregroundStyle(Color.LabelColors.labelPrimary)
        }
        .lineLimit(1)
    }
    
    private var saleItem: some View {
        HStack(alignment: .top, spacing: 8) {
            item.status.indicator
                .padding(.top, 2)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(item.status.title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(Color.LabelColors.labelPrimary)
                
                switch item.status {
                case .active(let end), .expiring(let end):
                    CountdownToDate(endDate: end)
                case .sold:
                    EmptyView()
                }
            }
        }
    }
}

#Preview {
    VStack(spacing: 16) {
        DashboardMarketView()
            .padding(.horizontal)
    }
}
