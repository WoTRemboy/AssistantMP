//
//  DashboardMarketView.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 22/01/2026.
//

import SwiftUI

struct DashboardMarketView: View {
   
    @State private var selected: MarketSegment = .general

    private let items: [MarketItem] = MarketItem.sample

    internal var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            headerView
            contentCard
        }
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

            Text(Texts.Dashboard.Market.title)
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
        .padding(.horizontal, 10)
    }

    private var contentCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            segmentedControl
                .padding(.horizontal, 10)
            
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    ZStack {
                        if selected == .general {
                            generalItems
                        } else {
                            saleItems
                        }
                    }
                    .padding(.horizontal, 10)
                    .animation(.smooth(duration: 0.25), value: selected)
                }
                .onChange(of: selected) { _, _ in
                    withAnimation(.smooth(duration: 0.25)) {
                        proxy.scrollTo("marketScrollStart", anchor: .leading)
                    }
                }
            }
        }
    }
    
    private var generalItems: some View {
        HStack(alignment: .top, spacing: 12) {
            Color.clear.frame(width: 1, height: 1).id("marketScrollStart")
            ForEach(items) { item in
                MarketItemCard(item: item, mode: .general)
            }
        }
        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .opacity))
        .id(MarketSegment.general.rawValue)
    }
    
    private var saleItems: some View {
        HStack(alignment: .top, spacing: 12) {
            Color.clear.frame(width: 1, height: 1).id("marketScrollStart")
            ForEach(items) { item in
                MarketItemCard(item: item, mode: .sale)
            }
        }
        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .opacity))
        .id(MarketSegment.sale.rawValue)
    }

    private var segmentedControl: some View {
        Picker("", selection: $selected) {
            ForEach(MarketSegment.allCases, id: \.self) { segment in
                Text(segment.title)
                    .tag(segment)
            }
        }
        .pickerStyle(.segmented)
    }
}

#Preview {
    VStack(spacing: 16) {
        DashboardMarketView()
            .padding(.horizontal)
    }
}

