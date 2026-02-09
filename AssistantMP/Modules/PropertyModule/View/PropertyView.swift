//
//  PropertyView.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 01/02/2026.
//

import SwiftUI

struct PropertyView: View {
    
    @StateObject private var viewModel = PropertyViewModel()
    @EnvironmentObject private var appRouter: AppRouter
    
    @State private var offset: CGFloat = 0
    internal var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 16) {
                titleLabel
                contentCard
            }
            .padding(.horizontal)
            .navigationBarHidden(true)
        }
        .coordinateSpace(name: "scroll")
        .onPreferenceChange(HeaderBottomPreferenceKey.self) { minY in
            withAnimation(.easeInOut(duration: 0.2)) {
                offset = minY
            }
        }
        .safeAreaInset(edge: .top) {
            propertyNavBar
        }
        .enableFillSwipePop(true)
    }
    
    private var titleLabel: some View {
        Text(Texts.Property.title)
            .font(.system(size: 25, weight: .bold))
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                GeometryReader { proxy in
                    Color.clear
                        .preference(
                            key: HeaderBottomPreferenceKey.self,
                            value: proxy.frame(in: .named("scroll")).minY
                        )
                }
            )
    }
    
    private var contentCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            addressSection
            ownerSection
            statusSection
            paymentSection
        }
    }
    
    private var addressSection: some View {
        PropertyAddressView(viewModel: viewModel)
    }
    
    private var ownerSection: some View {
        PropertyOwnerView()
    }
    
    private var statusSection: some View {
        Group {
            if let status = viewModel.selectedProperty.lockStatus {
                PropertyLockStatusView(
                    lockStatus: status,
                    viewModel: viewModel)
            }
        }
    }
    
    private var paymentSection: some View {
        Group {
            if let date = viewModel.selectedProperty.paymentDate {
                PropertyPaymentSection(paymentDate: date)
            }
        }
    }
    
    private var propertyNavBar: some View {
        PropertyCustomNavBar(title: Texts.Property.shortTitle, offset: offset)
    }
}

#Preview {
    PropertyView()
        .environmentObject(AppRouter())
}
