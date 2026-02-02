//
//  BankOperationModel.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 03/02/2026.
//

import Foundation
import SwiftUI

struct BankOperation {
    let id = UUID()
    let category: Category
    let amount: Int
    let date: Date
    
    enum Category {
        case income
        case transfer(to: String)
        case housePayment
        
        internal var name: String {
            switch self {
            case .income: return Texts.Bank.Transaction.income
            case .transfer(let to): return "\(Texts.Bank.Transaction.transfer): \(to)"
            case .housePayment: return Texts.Bank.Transaction.housePayment
            }
        }
        
        internal var image: Image {
            switch self {
            case .income: return Image.Bank.Operations.income
            case .transfer: return Image.Bank.Operations.transfer
            case .housePayment: return Image.Bank.Operations.housePayment
            }
        }
        
        internal var foreground: Color {
            switch self {
            case .income:
                Color(.systemGreen)
            case .transfer:
                Color.LabelColors.labelPrimary
            case .housePayment:
                Color.LabelColors.labelPrimary
            }
        }
        
        internal var isIncome: Bool {
            switch self {
            case .income: true
            default: false
            }
        }
    }
    
}

extension BankOperation {
    
    static var sample: BankOperation {
        BankOperation(category: .income, amount: 50_000, date: Date.makeDate(2026, 2, 20))
    }
    
    static var sampleList: [BankOperation] {
        [
            BankOperation(category: .income, amount: 50_000, date: Date.makeDate(2025, 6, 1)),
            BankOperation(category: .transfer(to: "Mike_Smith"), amount: 5_000, date: Date.makeDate(2025, 5, 25)),
            BankOperation(category: .housePayment, amount: 10_000, date: Date.makeDate(2025, 5, 22)),
            BankOperation(category: .income, amount: 100_000, date: Date.makeDate(2025, 5, 10))
        ]
    }
}
