//
//  CountToDateView.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 22/01/2026.
//

import SwiftUI

struct CountdownToDate: View {
    private let endDate: Date
    
    init(endDate: Date) {
        self.endDate = endDate
    }

    internal var body: some View {
        TimelineView(.periodic(from: .now, by: 1)) { context in
            let remaining = max(0, Int(endDate.timeIntervalSince(context.date)))
            Text(CountdownToDate.format(seconds: remaining))
                .font(.system(size: 12, weight: .regular))
                .foregroundStyle(Color.LabelColors.labelSecondary)
                .monospacedDigit()
                .contentTransition(.numericText())
                .animation(.snappy(duration: 0.25, extraBounce: 0), value: remaining)
        }
    }

    private static func format(seconds: Int) -> String {
        let hrs = seconds / 3600
        let mins = (seconds % 3600) / 60
        let secs = seconds % 60
        return String(format: "%02d:%02d:%02d", hrs, mins, secs)
    }
}
