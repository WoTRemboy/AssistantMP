//
//  CountingTextView.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 22/01/2026.
//

import SwiftUI

struct CountingText: View, Animatable {
    var value: Double
    var animatableData: Double {
        get { value }
        set { value = newValue }
    }

    var body: some View {
        let intValue = Int(round(value))
        let formatted = NumberFormatter.bankGrouping.string(from: NSNumber(value: intValue)) ?? "\(intValue)"
        return Text("$ \(formatted)")
            .monospacedDigit()
    }
}
