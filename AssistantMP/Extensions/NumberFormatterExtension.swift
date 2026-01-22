//
//  NumberFormatterExtension.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 22/01/2026.
//

import Foundation

extension NumberFormatter {
    static let bankGrouping: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.groupingSeparator = ","
        nf.usesGroupingSeparator = true
        return nf
    }()
}
