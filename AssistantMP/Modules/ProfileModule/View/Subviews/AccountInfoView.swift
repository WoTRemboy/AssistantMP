//
//  AccountInfoView.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 23/01/2026.
//

import SwiftUI

struct AccountInfoView: View {
    
    @State private var displayedProgress: Double = 0
    @State private var didAnimateProgress: Bool = false
    
    private let user: User
    
    init(user: User) {
        self.user = user
    }

    internal var body: some View {
        HStack(alignment: .center, spacing: 20) {
            avatar
            VStack(alignment: .leading, spacing: 6) {
                titleRow
                statsRow
            }
            Spacer(minLength: 0)
        }
    }

    private var avatar: some View {
        ZStack {
            progressRing
            avatarIcon
        }
        .onAppear {
            if !didAnimateProgress {
                displayedProgress = 0
                withAnimation(.easeOut(duration: 0.8)) {
                    displayedProgress = user.xpProgress
                }
                didAnimateProgress = true
            }
        }
        
        .overlay(alignment: .bottomTrailing) {
            levelOverlay
        }
    }
    
    private var progressRing: some View {
        Circle()
            .stroke(Color.secondary.opacity(0.2), lineWidth: 6)
            .frame(width: 76, height: 76)
            .overlay {
                Circle()
                    .trim(from: 0, to: displayedProgress)
                    .stroke(
                        Color.LabelColors.labelSecondary,
                        style: StrokeStyle(lineWidth: 6, lineCap: .round, lineJoin: .round)
                    )
                    .rotationEffect(.degrees(30))
                    .frame(width: 76, height: 76)
            }
    }
    
    private var avatarIcon: some View {
        Circle()
            .fill(Color(.systemGray5))
            .frame(width: 68, height: 68)
            .overlay {
                Image.Profile.placeholder
            }
    }
    
    private var levelOverlay: some View {
        Text("\(user.level)")
            .font(.system(size: 12, weight: .bold))
            .foregroundStyle(Color.LabelColors.labelWhite)
            .lineLimit(1)
            .minimumScaleFactor(0.2)
        
            .frame(width: 18, height: 18)
            .padding(3)
            .background(
                Circle()
                    .fill(Color.LabelColors.labelSecondary)
            )
            .offset(x: 6, y: -7)
    }
    
    private var titleRow: some View {
        HStack(alignment: .top, spacing: 10) {
            Text(user.name)
                .font(.system(size: 25, weight: .bold))
                .foregroundStyle(Color.LabelColors.labelPrimary)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            
            Image.Profile.edit
        }
    }

    private var statsRow: some View {
        HStack(spacing: 4) {
            Text("\(Texts.Profile.level): \(user.level)")
            Text("•")
            Text("\(Texts.Profile.xp): \(formatted(user.currentXP)) / \(formatted(user.maxXP))")
                
        }
        .font(.system(size: 14, weight: .regular))
        .foregroundStyle(Color.LabelColors.labelPrimary)
        .lineLimit(1)
    }

    private func formatted(_ value: Int) -> String {
        value.formatted(.number.grouping(.automatic))
    }
}

#Preview {
    AccountInfoView(user: .sample)
}
