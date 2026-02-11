//
//  PropertyPaymentSection.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 02/02/2026.
//

import SwiftUI

struct PropertyPaymentSection: View {
    
    private let paymentDate: Date
    private let daysLeftText: String
    private let daysLeftWarning: PropertyWarningStyle
    
    init(paymentDate: Date) {
        self.paymentDate = paymentDate
        self.daysLeftText = Date.daysRemaining(until: paymentDate)
        self.daysLeftWarning = Date.daysUntil(paymentDate) <= 3 ? .warning : .info
    }
    
    internal var body: some View {
        VStack {
            if daysLeftWarning == .warning {
                warningSection
            }
            paymentSection
        }
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color(.systemRed).opacity(0.08))
        )
    }
    
    private var warningSection: some View {
        HStack(alignment: .top, spacing: 10) {
            Image.Dashboard.info
            
            VStack(alignment: .leading, spacing: 4) {
                Text("\(Texts.Property.warning) \(daysLeftText)")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(Color.Label.primary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 12)
        .padding(.vertical, 16)
    }
    
    private var paymentSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top) {
                Image.Property.time
                
                VStack(alignment: .leading, spacing: 6) {
                    Text("\(Texts.Property.deadline):")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(Color.Label.primary)
                    
                    HStack(spacing: 12) {
                        paymentPill
                            .fixedSize(horizontal: true, vertical: false)
                            .layoutPriority(1)
                        paymentDateView
                            .layoutPriority(0)
                    }
                    
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color(.systemGray6))
        )
    }
    
    private var paymentDateView: some View {
        let dateText = DateFormatter.shortPayment.string(from: paymentDate)
        return VStack(alignment: .leading, spacing: 3) {
            Text("\(Texts.Property.date):")
                .font(.system(size: 14, weight: .regular))
                .foregroundStyle(Color.Label.secondary)
            Text(dateText)
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(Color.Label.primary)
                .contentTransition(.opacity)
                .animation(.easeInOut(duration: 0.2), value: dateText)
        }
    }
    
    private var paymentPill: some View {
        Text("\(Texts.Property.remaining) \(daysLeftText)")
            .font(.system(size: 14, weight: .bold))
            .foregroundStyle(daysLeftWarning.foreground)
            .contentTransition(.opacity)
            .animation(.easeInOut(duration: 0.2), value: daysLeftText)
        
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(
                Color.Back.backDefault
            )
            .overlay(alignment: .bottom) {
                timeLeftBar
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    private var timeLeftBar: some View {
        let days = CGFloat(Date.daysUntil(paymentDate))
        
        return PropertyTimeLeftBar(
            fraction: min(1, max(0, days / 30)),
            height: 3,
            style: daysLeftWarning)
    }
}

#Preview {
    let sampleDate = PropertyItem.sample.paymentDate ?? .now
    PropertyPaymentSection(paymentDate: sampleDate)
}
